import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

/// 文本片段：普通文字或 LaTeX 公式。
class MathSegment {
  const MathSegment(this.text, {this.isMath = false, this.display = false});

  final String text;
  final bool isMath;
  final bool display;
}

/// 把混合文本拆成普通文字与 LaTeX 公式。
///
/// 支持 `$...$`、`$$...$$`、`\(...\)`、`\[...\]`；
/// 若整段没有任何分隔符但明显是纯公式（含反斜杠且无中文），整体按公式渲染。
List<MathSegment> parseMathText(String input) {
  final segments = <MathSegment>[];
  final buffer = StringBuffer();

  void flushText() {
    if (buffer.isEmpty) return;
    segments.add(MathSegment(buffer.toString()));
    buffer.clear();
  }

  var index = 0;
  while (index < input.length) {
    String? close;
    var openLength = 0;
    var display = false;
    if (input.startsWith(r'$$', index)) {
      close = r'$$';
      openLength = 2;
      display = true;
    } else if (input.startsWith(r'$', index)) {
      close = r'$';
      openLength = 1;
    } else if (input.startsWith(r'\(', index)) {
      close = r'\)';
      openLength = 2;
    } else if (input.startsWith(r'\[', index)) {
      close = r'\]';
      openLength = 2;
      display = true;
    }

    if (close == null) {
      buffer.write(input[index]);
      index++;
      continue;
    }

    final end = input.indexOf(close, index + openLength);
    if (end < 0) {
      buffer.write(input.substring(index));
      index = input.length;
      continue;
    }
    flushText();
    final formula = input.substring(index + openLength, end).trim();
    if (formula.isNotEmpty) {
      segments.add(MathSegment(formula, isMath: true, display: display));
    }
    index = end + close.length;
  }
  flushText();

  if (segments.length == 1 && !segments.first.isMath &&
      _looksLikeMath(segments.first.text)) {
    return [MathSegment(segments.first.text.trim(), isMath: true)];
  }
  if (segments.length == 1 &&
      !segments.first.isMath &&
      segments.first.text.contains(r'\')) {
    return _segmentMixedRaw(segments.first.text);
  }
  return segments;
}

/// 把“中文文字 + 未加 $ 的裸 LaTeX”切成文字/公式片段。
List<MathSegment> _segmentMixedRaw(String input) {
  final cjk = RegExp(r'[\u4e00-\u9fff\u3000-\u303f\uff00-\uffef]+');
  final result = <MathSegment>[];
  var cursor = 0;
  void addChunk(String chunk, {required bool isCjk}) {
    final trimmed = chunk.trim();
    if (trimmed.isEmpty) return;
    if (isCjk) {
      result.add(MathSegment(chunk));
      return;
    }
    final isMath = trimmed.contains(r'\') ||
        trimmed.contains('^') ||
        trimmed.contains('_') ||
        trimmed.contains('=');
    result.add(
      isMath
          ? MathSegment(trimmed, isMath: true)
          : MathSegment(chunk),
    );
  }

  for (final match in cjk.allMatches(input)) {
    if (match.start > cursor) {
      addChunk(input.substring(cursor, match.start), isCjk: false);
    }
    addChunk(match.group(0)!, isCjk: true);
    cursor = match.end;
  }
  if (cursor < input.length) {
    addChunk(input.substring(cursor), isCjk: false);
  }
  return result.isEmpty ? [MathSegment(input)] : result;
}

bool _looksLikeMath(String text) {
  final trimmed = text.trim();
  if (trimmed.isEmpty) return false;
  if (RegExp(r'[\u4e00-\u9fff]').hasMatch(trimmed)) return false;
  return trimmed.contains(r'\') ||
      trimmed.contains('^') ||
      trimmed.contains('_') ||
      trimmed.contains('=');
}

/// 渲染混合 LaTeX 的文本；解析失败时回退为原文。
class MathText extends StatelessWidget {
  const MathText(
    this.text, {
    super.key,
    this.style,
    this.maxLines,
    this.textAlign,
  });

  final String text;
  final TextStyle? style;
  final int? maxLines;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = style ?? DefaultTextStyle.of(context).style;
    final segments = parseMathText(text);
    if (segments.isEmpty) return const SizedBox.shrink();

    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : MediaQuery.sizeOf(context).width - 32;

        Widget mathWidget(MathSegment segment) {
          return ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Math.tex(
                segment.text,
                mathStyle:
                    segment.display ? MathStyle.display : MathStyle.text,
                textStyle: effectiveStyle,
                onErrorFallback: (_) =>
                    Text(segment.text, style: effectiveStyle),
              ),
            ),
          );
        }

        if (segments.length == 1 && segments.first.isMath) {
          return mathWidget(segments.first);
        }

        final content = Wrap(
          spacing: 0,
          runSpacing: 2,
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: textAlign == TextAlign.center
              ? WrapAlignment.center
              : WrapAlignment.start,
          children: [
            for (final segment in segments)
              if (segment.isMath)
                mathWidget(segment)
              else
                Text(
                  segment.text,
                  style: effectiveStyle,
                  textAlign: textAlign,
                ),
          ],
        );

        if (maxLines == null) return content;
        final lineHeight = (effectiveStyle.fontSize ?? 14) * 1.5;
        return ClipRect(
          child: SizedBox(
            height: lineHeight * maxLines!,
            child: content,
          ),
        );
      },
    );
  }
}
