import 'package:flutter/widgets.dart';
import 'package:flutter_dsl/flutter_dsl.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const original = SizedBox(key: Key('orig'));
  ColoredBox wrap(Widget w) => ColoredBox(
        key: const Key('wrap'),
        color: const Color(0xFF000000),
        child: w,
      );

  test('.onTrue applies transform when true', () {
    final r = original.onTrue(true, wrap);
    expect(r, isA<ColoredBox>());
  });

  test('.onTrue returns original when false', () {
    final r = original.onTrue(false, wrap);
    expect(r, same(original));
  });

  test('.onFalse applies when condition is false', () {
    final r = original.onFalse(false, wrap);
    expect(r, isA<ColoredBox>());
  });

  test('.onFalse returns original when condition is true', () {
    final r = original.onFalse(true, wrap);
    expect(r, same(original));
  });

  test('.when picks first true case', () {
    final r = original.when({false: wrap, true: wrap});
    expect(r, isA<ColoredBox>());
  });

  test('.when returns original when no key is true', () {
    final r = original.when({false: wrap});
    expect(r, same(original));
  });

  testWidgets('WhenWidget renders the matching builder', (tester) async {
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: WhenWidget<int>(
          value: 2,
          cases: {
            1: () => const SizedBox(key: Key('one')),
            2: () => const SizedBox(key: Key('two')),
          },
        ),
      ),
    );
    expect(find.byKey(const Key('two')), findsOneWidget);
    expect(find.byKey(const Key('one')), findsNothing);
  });

  testWidgets('WhenWidget falls back to orElse', (tester) async {
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: WhenWidget<int>(
          value: 99,
          cases: {1: () => const SizedBox(key: Key('one'))},
          orElse: () => const SizedBox(key: Key('fallback')),
        ),
      ),
    );
    expect(find.byKey(const Key('fallback')), findsOneWidget);
  });
}
