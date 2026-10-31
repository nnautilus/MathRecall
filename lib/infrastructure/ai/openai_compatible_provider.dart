import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

import '../../core/errors/app_error.dart';
import '../../domain/entities/ai_draft.dart';
import '../../domain/repositories/draft_repository.dart';
import 'ai_config.dart';

/// OpenAI-compatible 视觉识别实现（/chat/completions + image_url）。
class OpenAiCompatibleProvider implements AiVisionProvider {
  OpenAiCompatibleProvider(this.config, {http.Client? client})
      : _client = client ?? http.Client();

  final AiConfig config;
  final http.Client _client;

  static const _promptVersion = 'v6';
  static const _basePrompt = r'''
你是考研数学（大学数学）错题录入助手。请识别图片中的所有题目，按题拆分，并转录为 LaTeX。
如果图片只给出题目，请自行解答，填写答案与解法，不要因为原图没有答案就留空。
只输出 JSON 对象，不要输出 Markdown 或解释。格式：
{"questions":[{"prompt_latex":"求 $x^2+1=0$ 的解","answer_latex":"$x=\pm i$","solution_latex":"配方法或求根公式","knowledge_points":["高等数学/函数与极限/函数解析式"],"confidence":0.0}]}
要求：
1. 题干完整；公式用 LaTeX，并用 $...$ 包裹（例如 $x^2$）；普通文字不要放进 $ 内；
2. 一道题包含 (1)(2) 等多个小问时：
   - 优先合并为一个题目，prompt_latex 保留全部小问；
   - answer_latex 与 solution_latex 必须按小问分别给出完整答案与过程；
   - 如果拆成多道题，每道小题都必须有自己独立完整的 answer_latex 与 solution_latex，不能只复制题干；
3. 答案与解法尽量填写；只有确实无法确定时才填 null，不要直接留空；
4. 这是考研数学，知识点必须是大学数学体系：
   - 科目只能是：高等数学、线性代数、概率论与数理统计；
   - 禁止使用高中数学、初中数学、小学等名称；
5. knowledge_points 优先从下面“现有知识点”中选择完整路径，最多 3 个；
   如果都不匹配，也必须给出 1~3 个最合适的大学知识点路径，不得返回空数组；
6. suggested_knowledge_points：当 knowledge_points 使用建议路径时，可以同时填写；否则可省略；
7. confidence 为 0~1 的识别置信度；
8. 不要输出 Markdown 代码块。
''';

  String _buildPrompt(List<String> knowledgePaths) {
    final paths = <String>[];
    for (final path in knowledgePaths) {
      final trimmed = path.trim();
      if (trimmed.isNotEmpty && !paths.contains(trimmed)) {
        paths.add(trimmed);
      }
    }
    final buffer = StringBuffer(_basePrompt);
    buffer.writeln();
    if (paths.isEmpty) {
      buffer.writeln(
        '现有知识点：无。knowledge_points 必须给出 1~3 个最合适的大学知识点路径'
        '（科目/章节/知识点），不要留空。',
      );
    } else {
      buffer.writeln(
        '现有知识点（优先从中选择完整路径；没有匹配也必须给出建议路径，不得留空）：',
      );
      for (final path in paths.take(300)) {
        buffer.writeln('- $path');
      }
    }
    return buffer.toString();
  }

  @override
  String get providerName => config.providerName;

  @override
  String get model => config.model;

  @override
  String get promptVersion => _promptVersion;

  @override
  Future<AiDraftResult> analyzeImage({
    required Uint8List bytes,
    required String mime,
    String? userHint,
    List<String> knowledgePaths = const [],
  }) async {
    if (!config.isConfigured) {
      throw const AppError(AppErrorKind.config, 'AI 未配置');
    }
    final dataUrl = 'data:$mime;base64,${base64Encode(bytes)}';
    final body = <String, Object?>{
      'model': config.model,
      'temperature': 0.1,
      'messages': [
        {'role': 'system', 'content': _buildPrompt(knowledgePaths)},
        {
          'role': 'user',
          'content': [
            if (userHint != null && userHint.trim().isNotEmpty)
              {'type': 'text', 'text': '补充信息：${userHint.trim()}'},
            {
              'type': 'image_url',
              'image_url': {'url': dataUrl},
            },
          ],
        },
      ],
    };

    for (var parseAttempt = 0; parseAttempt < 2; parseAttempt++) {
      final response = await _post(body);
      try {
        final content = _extractContent(response);
        final raw = _extractJson(content);
        return AiDraftResult(
          questions: _parseQuestions(raw),
          rawJson: jsonEncode(raw),
          provider: providerName,
          model: model,
          promptVersion: promptVersion,
        );
      } on AppError catch (error) {
        if (error.kind == AppErrorKind.ai && parseAttempt == 0) {
          continue;
        }
        rethrow;
      }
    }
    throw const AppError(AppErrorKind.ai, 'AI 返回格式无法解析');
  }

  Future<Map<String, dynamic>> _post(Map<String, Object?> body) async {
    final base = config.baseUrl.trim().replaceAll(RegExp(r'/+$'), '');
    final uri = Uri.parse('$base/chat/completions');
    Object? lastError;
    for (var attempt = 0; attempt < 3; attempt++) {
      try {
        final response = await _client
            .post(
              uri,
              headers: {
                'Authorization': 'Bearer ${config.apiKey}',
                'Content-Type': 'application/json',
              },
              body: jsonEncode(body),
            )
            .timeout(const Duration(seconds: 90));
        if (response.statusCode >= 200 && response.statusCode < 300) {
          final decoded = jsonDecode(utf8.decode(response.bodyBytes));
          if (decoded is Map<String, dynamic>) {
            return decoded;
          }
          throw const AppError(AppErrorKind.ai, 'AI 响应不是 JSON 对象');
        }
        if (response.statusCode == 401 || response.statusCode == 403) {
          throw const AppError(AppErrorKind.config, 'AI 鉴权失败，请检查 API Key');
        }
        final retryable = response.statusCode == 429 ||
            response.statusCode >= 500;
        lastError = AppError(
          retryable ? AppErrorKind.network : AppErrorKind.ai,
          'AI 请求失败：HTTP ${response.statusCode}',
        );
        if (!retryable) break;
      } on TimeoutException catch (error) {
        lastError = AppError(AppErrorKind.network, 'AI 请求超时', cause: error);
      } on SocketException catch (error) {
        lastError = AppError(AppErrorKind.network, '无法连接 AI 服务', cause: error);
      } on http.ClientException catch (error) {
        lastError = AppError(AppErrorKind.network, 'AI 网络请求失败', cause: error);
      } on AppError {
        rethrow;
      } catch (error) {
        lastError = AppError(AppErrorKind.unknown, 'AI 请求异常', cause: error);
      }
      if (attempt < 2) {
        await Future<void>.delayed(
          Duration(milliseconds: 300 * (1 << attempt)),
        );
      }
    }
    if (lastError is AppError) throw lastError;
    throw AppError(AppErrorKind.unknown, 'AI 请求失败', cause: lastError);
  }

  String _extractContent(Map<String, dynamic> response) {
    final choices = response['choices'];
    if (choices is! List || choices.isEmpty) {
      throw const AppError(AppErrorKind.ai, 'AI 响应缺少 choices');
    }
    final message = (choices.first as Map)['message'];
    if (message is! Map) {
      throw const AppError(AppErrorKind.ai, 'AI 响应缺少 message');
    }
    final content = message['content'];
    if (content is String && content.trim().isNotEmpty) {
      return content;
    }
    if (content is List) {
      return content
          .whereType<Map>()
          .map((part) => part['text']?.toString() ?? '')
          .join();
    }
    throw const AppError(AppErrorKind.ai, 'AI 未返回内容');
  }

  Map<String, dynamic> _extractJson(String content) {
    var text = content.trim();
    if (text.startsWith('```')) {
      text = text.replaceFirst(RegExp(r'^```[a-zA-Z]*\s*'), '');
      text = text.replaceFirst(RegExp(r'\s*```$'), '');
    }
    final start = text.indexOf('{');
    final end = text.lastIndexOf('}');
    if (start < 0 || end <= start) {
      throw const AppError(AppErrorKind.ai, 'AI 返回格式无法解析');
    }
    try {
      final decoded = jsonDecode(text.substring(start, end + 1));
      if (decoded is Map<String, dynamic>) return decoded;
      if (decoded is List) return {'questions': decoded};
    } catch (_) {
      throw const AppError(AppErrorKind.ai, 'AI 返回 JSON 解析失败');
    }
    throw const AppError(AppErrorKind.ai, 'AI 返回格式无法解析');
  }

  List<AiQuestionDraft> _parseQuestions(Map<String, dynamic> raw) {
    final list = raw['questions'];
    if (list is! List || list.isEmpty) {
      throw const AppError(AppErrorKind.ai, 'AI 未识别到题目');
    }
    final questions = <AiQuestionDraft>[];
    for (final item in list) {
      if (item is! Map) continue;
      final prompt = _string(item, ['prompt_latex', 'promptLatex', 'prompt']) ?? '';
      if (prompt.trim().isEmpty) continue;
      final constrained = _stringList(
        item['knowledge_points'] ?? item['knowledgePoints'],
      )
          .where((path) => !RegExp('高中|初中|小学').hasMatch(path))
          .toList();
      final suggested = _stringList(
        item['suggested_knowledge_points'] ??
            item['suggestedKnowledgePoints'],
      )
          .where((path) => !RegExp('高中|初中|小学').hasMatch(path))
          .toList();
      questions.add(
        AiQuestionDraft(
          promptLatex: prompt.trim(),
          answerLatex: _string(item, ['answer_latex', 'answerLatex', 'answer']),
          solutionLatex:
              _string(item, ['solution_latex', 'solutionLatex', 'solution']),
          // 没有匹配到现有知识点时，用建议路径填充，避免分类空白。
          knowledgePoints:
              constrained.isNotEmpty ? constrained : suggested,
          suggestedKnowledgePoints: suggested,
          confidence: _double(item['confidence']),
        ),
      );
    }
    if (questions.isEmpty) {
      throw const AppError(AppErrorKind.ai, 'AI 未识别到有效题目');
    }
    return questions;
  }

  String? _string(Map item, List<String> keys) {
    for (final key in keys) {
      final value = item[key];
      if (value is String && value.trim().isNotEmpty) return value.trim();
    }
    return null;
  }

  List<String> _stringList(Object? value) {
    if (value is List) {
      return value
          .map((item) => item.toString().trim())
          .where((item) => item.isNotEmpty)
          .toList();
    }
    if (value is String && value.trim().isNotEmpty) {
      return value
          .split(RegExp(r'[,，/]'))
          .map((item) => item.trim())
          .where((item) => item.isNotEmpty)
          .toList();
    }
    return const [];
  }

  double? _double(Object? value) {
    if (value is num) return value.toDouble().clamp(0, 1);
    if (value is String) return double.tryParse(value)?.clamp(0, 1);
    return null;
  }
}
