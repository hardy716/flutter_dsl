import 'package:flutter/widgets.dart';
import 'package:flutter_dsl/flutter_dsl.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _wrap({required Size size, required Widget child}) {
  return MediaQuery(
    data: MediaQueryData(size: size),
    child: Directionality(textDirection: TextDirection.ltr, child: child),
  );
}

void main() {
  group('ResponsiveScope.of', () {
    testWidgets('returns scope-resolved size when wrapped', (tester) async {
      late ScreenSize captured;
      await tester.pumpWidget(
        _wrap(
          size: const Size(900, 600),
          child: ResponsiveScope(
            child: Builder(
              builder: (ctx) {
                captured = ResponsiveScope.of(ctx);
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      );
      expect(captured, ScreenSize.expanded);
    });

    testWidgets('falls back to MediaQuery + material3 when not wrapped',
        (tester) async {
      late ScreenSize captured;
      await tester.pumpWidget(
        _wrap(
          size: const Size(500, 800),
          child: Builder(
            builder: (ctx) {
              captured = ResponsiveScope.of(ctx);
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      expect(captured, ScreenSize.compact);
    });
  });

  group('ResponsiveScope.maybeOf', () {
    testWidgets('returns null when no scope present', (tester) async {
      ScreenSize? captured;
      await tester.pumpWidget(
        _wrap(
          size: const Size(500, 800),
          child: Builder(
            builder: (ctx) {
              captured = ResponsiveScope.maybeOf(ctx);
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      expect(captured, isNull);
    });
  });

  group('ResponsiveScope.dataOf', () {
    testWidgets('exposes width and breakpoints when wrapped', (tester) async {
      late ResponsiveData data;
      await tester.pumpWidget(
        _wrap(
          size: const Size(1300, 800),
          child: ResponsiveScope(
            breakpoints: const [400, 800, 1200, 1600],
            child: Builder(
              builder: (ctx) {
                data = ResponsiveScope.dataOf(ctx);
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      );
      expect(data.width, 1300);
      expect(data.size, ScreenSize.large);
      expect(data.breakpoints, const [400, 800, 1200, 1600]);
    });
  });

  group('custom breakpoints', () {
    testWidgets('apply via ResponsiveScope', (tester) async {
      late ScreenSize captured;
      await tester.pumpWidget(
        _wrap(
          size: const Size(500, 800),
          child: ResponsiveScope(
            breakpoints: const [300, 700, 1100, 1500],
            child: Builder(
              builder: (ctx) {
                captured = ResponsiveScope.of(ctx);
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      );
      expect(captured, ScreenSize.medium);
    });
  });
}
