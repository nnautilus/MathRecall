import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mathrecall/presentation/widgets/math_text.dart';

void main() {
  test('splits inline and display math', () {
    final segments = parseMathText(
      r'求极限 $\lim_{x\to0}\frac{\sin x}{x}$，并说明理由。',
    );
    expect(segments.map((s) => s.isMath), [false, true, false]);
    expect(segments[1].text, r'\lim_{x\to0}\frac{\sin x}{x}');
  });

  test('supports display and paren delimiters', () {
    final segments = parseMathText(r'$$a^2+b^2$$ 与 \(x^2\)');
    expect(segments.where((s) => s.isMath), hasLength(2));
    expect(segments.first.display, isTrue);
    expect(segments.last.isMath, isTrue);
  });

  test('treats a single raw formula as math', () {
    final segments = parseMathText(r'\frac{\sin x}{x}');
    expect(segments, hasLength(1));
    expect(segments.single.isMath, isTrue);
  });

  test('keeps plain Chinese text as text', () {
    final segments = parseMathText('矩阵求逆');
    expect(segments.single.isMath, isFalse);
  });

  test('splits mixed Chinese and raw LaTeX without delimiters', () {
    final segments = parseMathText(
      r'已知函数 f(x)=\arcsin(x-1)+\ln(1-x)，求定义域',
    );
    expect(segments.any((s) => s.isMath), isTrue);
    expect(
      segments.where((s) => s.isMath).single.text,
      contains(r'\arcsin'),
    );
    expect(segments.first.isMath, isFalse);
  });

  testWidgets('long formula is scaled instead of overflowing', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SizedBox(
            width: 180,
            child: MathText(
              r'f(x+2)=(x+2)[(x+2)^2-4]=x(x+2)(x+4)',
            ),
          ),
        ),
      ),
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('mixed text with long formula does not overflow',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SizedBox(
            width: 200,
            child: MathText(
              r'由 f(x)=-\frac{1}{2}f(x+2)，得 f(x)=-\frac{1}{2}x(x+2)(x+4)。',
            ),
          ),
        ),
      ),
    );
    expect(tester.takeException(), isNull);
  });
}
