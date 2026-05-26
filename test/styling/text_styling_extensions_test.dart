import 'package:flutter/material.dart';
import 'package:flutter_dsl/flutter_dsl.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('.fontSize sets fontSize and preserves other style fields', () {
    final t = const Text(
      'x',
      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
    ).fontSize(28);

    expect(t.style?.fontSize, 28);
    expect(t.style?.fontWeight, FontWeight.bold);
    expect(t.style?.color, Colors.red);
  });

  test('.textColor merges color without dropping fontSize', () {
    final t =
        const Text('x', style: TextStyle(fontSize: 14)).textColor(Colors.blue);
    expect(t.style?.color, Colors.blue);
    expect(t.style?.fontSize, 14);
  });

  test('chained .fontSize().textColor() composes', () {
    final t = const Text('x').fontSize(20).textColor(Colors.green);
    expect(t.style?.fontSize, 20);
    expect(t.style?.color, Colors.green);
  });

  test('.italic / .underline set decoration / fontStyle', () {
    final i = const Text('x').italic();
    expect(i.style?.fontStyle, FontStyle.italic);

    final u = const Text('x').underline();
    expect(u.style?.decoration, TextDecoration.underline);
  });

  test('.fontWeight sets fontWeight and preserves other style fields', () {
    final t = const Text(
      'x',
      style: TextStyle(fontSize: 14, color: Colors.red),
    ).fontWeight(FontWeight.w800);

    expect(t.style?.fontWeight, FontWeight.w800);
    expect(t.style?.fontSize, 14);
    expect(t.style?.color, Colors.red);
  });

  test('.letterSpacing sets letterSpacing and preserves other fields', () {
    final t =
        const Text('x', style: TextStyle(fontSize: 14)).letterSpacing(1.5);
    expect(t.style?.letterSpacing, 1.5);
    expect(t.style?.fontSize, 14);
  });

  test('.lineHeight sets TextStyle.height', () {
    final t = const Text('x', style: TextStyle(fontSize: 14)).lineHeight(1.8);
    expect(t.style?.height, 1.8);
    expect(t.style?.fontSize, 14);
  });

  test('preserves textAlign / maxLines / overflow', () {
    final t = const Text(
      'x',
      textAlign: TextAlign.center,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    ).fontSize(16);
    expect(t.textAlign, TextAlign.center);
    expect(t.maxLines, 2);
    expect(t.overflow, TextOverflow.ellipsis);
  });

  test('asserts on Text.rich', () {
    const rich = Text.rich(TextSpan(text: 'x'));
    expect(() => rich.fontSize(12), throwsA(isA<AssertionError>()));
  });
}
