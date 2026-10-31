import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:mathrecall/core/errors/app_error.dart';
import 'package:mathrecall/infrastructure/ai/ai_config.dart';
import 'package:mathrecall/infrastructure/ai/openai_compatible_provider.dart';

void main() {
  AiConfig config() => const AiConfig(
        baseUrl: 'https://example.com/v1',
        model: 'vlm',
        apiKey: 'key',
      );

  test('parses fenced JSON response into questions', () async {
    final client = MockClient((request) async {
      expect(
        request.url.toString(),
        'https://example.com/v1/chat/completions',
      );
      expect(request.headers['Authorization'], 'Bearer key');
      final body = jsonDecode(request.body) as Map<String, dynamic>;
      expect(body['model'], 'vlm');
      expect(body['messages'], isA<List>());
      return http.Response.bytes(
        utf8.encode(jsonEncode({
          'choices': [
            {
              'message': {
                'content': '```json\n'
                    '{"questions":[{"prompt_latex":"题干","answer_latex":"1",'
                    '"knowledge_points":["高中数学/函数","高等数学/函数与极限/函数解析式"],"confidence":0.9}]}\n'
                    '```',
              },
            },
          ],
        })),
        200,
        headers: {'content-type': 'application/json; charset=utf-8'},
      );
    });

    final provider = OpenAiCompatibleProvider(config(), client: client);
    final result = await provider.analyzeImage(
      bytes: Uint8List.fromList([1, 2, 3]),
      mime: 'image/jpeg',
    );

    expect(result.questions, hasLength(1));
    expect(result.questions.single.promptLatex, '题干');
    expect(result.questions.single.knowledgePoints,
        ['高等数学/函数与极限/函数解析式']);
    expect(result.questions.single.confidence, 0.9);
    expect(result.model, 'vlm');
  });

  test('uses suggested knowledge points when no existing match', () async {
    final client = MockClient(
      (request) async => http.Response.bytes(
        utf8.encode(jsonEncode({
          'choices': [
            {
              'message': {
                'content': '{"questions":[{"prompt_latex":"题干",'
                    '"knowledge_points":[],'
                    '"suggested_knowledge_points":["高等数学/函数与极限/函数解析式"]}]}',
              },
            },
          ],
        })),
        200,
        headers: {'content-type': 'application/json; charset=utf-8'},
      ),
    );
    final provider = OpenAiCompatibleProvider(config(), client: client);

    final result = await provider.analyzeImage(
      bytes: Uint8List.fromList([1]),
      mime: 'image/jpeg',
    );
    expect(
      result.questions.single.knowledgePoints,
      ['高等数学/函数与极限/函数解析式'],
    );
  });

  test('throws AppError on HTTP 401', () async {
    final client = MockClient((request) async => http.Response('unauthorized', 401));
    final provider = OpenAiCompatibleProvider(config(), client: client);

    await expectLater(
      provider.analyzeImage(
        bytes: Uint8List.fromList([1]),
        mime: 'image/jpeg',
      ),
      throwsA(isA<AppError>()),
    );
  });

  test('throws AppError on unparseable content', () async {
    final client = MockClient(
      (request) async => http.Response(
        jsonEncode({
          'choices': [
            {
              'message': {'content': 'not json'},
            },
          ],
        }),
        200,
      ),
    );
    final provider = OpenAiCompatibleProvider(config(), client: client);

    await expectLater(
      provider.analyzeImage(
        bytes: Uint8List.fromList([1]),
        mime: 'image/jpeg',
      ),
      throwsA(isA<AppError>()),
    );
  });
}
