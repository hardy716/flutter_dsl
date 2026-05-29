import 'package:flutter/widgets.dart';
import 'package:flutter_dsl/flutter_dsl.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('default scales follow the documented values', () {
    const t = DesignTokens();
    expect(
      [t.space.xs, t.space.sm, t.space.md, t.space.lg, t.space.xl, t.space.xxl],
      [4, 8, 16, 24, 32, 48],
    );
    expect(
      [t.radius.sm, t.radius.md, t.radius.lg, t.radius.pill],
      [4, 8, 16, 999],
    );
  });

  test('value equality drives updateShouldNotify correctness', () {
    expect(const DesignTokens(), const DesignTokens());
    expect(const SpacingScale(md: 20), isNot(const SpacingScale()));
    expect(
      const DesignTokens(space: SpacingScale(md: 20)),
      isNot(const DesignTokens()),
    );
  });

  testWidgets('of falls back to defaults when no scope is present',
      (tester) async {
    DesignTokens? seen;
    await tester.pumpWidget(
      Builder(
        builder: (context) {
          seen = DesignTokensScope.of(context);
          return const SizedBox.shrink();
        },
      ),
    );
    expect(seen, DesignTokens.fallback);
    expect(seen!.space.md, 16);
  });

  testWidgets('of returns the nearest scope tokens', (tester) async {
    DesignTokens? seen;
    await tester.pumpWidget(
      DesignTokensScope(
        tokens: const DesignTokens(space: SpacingScale(md: 20)),
        child: Builder(
          builder: (context) {
            seen = DesignTokensScope.of(context);
            return const SizedBox.shrink();
          },
        ),
      ),
    );
    expect(seen!.space.md, 20);
  });

  testWidgets('maybeOf returns null without a scope', (tester) async {
    DesignTokens? seen = const DesignTokens();
    await tester.pumpWidget(
      Builder(
        builder: (context) {
          seen = DesignTokensScope.maybeOf(context);
          return const SizedBox.shrink();
        },
      ),
    );
    expect(seen, isNull);
  });
}
