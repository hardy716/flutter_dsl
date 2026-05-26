import 'package:flutter/widgets.dart';
import 'package:flutter_dsl/flutter_dsl.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _wrap(Size size, Widget child) => MediaQuery(
      data: MediaQueryData(size: size),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: ResponsiveScope(child: child),
      ),
    );

void main() {
  group('Responsive.value', () {
    testWidgets('returns mobile value on compact', (tester) async {
      double? captured;
      await tester.pumpWidget(
        _wrap(
          const Size(400, 800),
          Builder(
            builder: (ctx) {
              captured = Responsive.value(ctx, mobile: 8.0, desktop: 24.0);
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      expect(captured, 8.0);
    });

    testWidgets('returns desktop value on large', (tester) async {
      double? captured;
      await tester.pumpWidget(
        _wrap(
          const Size(1400, 800),
          Builder(
            builder: (ctx) {
              captured = Responsive.value(ctx, mobile: 8.0, desktop: 24.0);
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      expect(captured, 24.0);
    });

    testWidgets('falls back desktop → tablet → mobile', (tester) async {
      double? captured;
      await tester.pumpWidget(
        _wrap(
          const Size(1400, 800),
          Builder(
            builder: (ctx) {
              captured = Responsive.value(ctx, mobile: 8.0, tablet: 16.0);
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      expect(captured, 16.0);
    });
  });

  group('Responsive.when', () {
    testWidgets('picks mobile widget on compact', (tester) async {
      await tester.pumpWidget(
        _wrap(
          const Size(400, 800),
          Builder(
            builder: (ctx) {
              return Responsive.when(
                ctx,
                mobile: const SizedBox(key: Key('m'), width: 1, height: 1),
                desktop: const SizedBox(key: Key('d'), width: 1, height: 1),
              );
            },
          ),
        ),
      );
      expect(find.byKey(const Key('m')), findsOneWidget);
      expect(find.byKey(const Key('d')), findsNothing);
    });
  });

  group('Responsive.isMobile/isTablet/isDesktop', () {
    testWidgets('flags compact as mobile', (tester) async {
      bool? mobile, tablet, desktop;
      await tester.pumpWidget(
        _wrap(
          const Size(400, 800),
          Builder(
            builder: (ctx) {
              mobile = Responsive.isMobile(ctx);
              tablet = Responsive.isTablet(ctx);
              desktop = Responsive.isDesktop(ctx);
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      expect(mobile, isTrue);
      expect(tablet, isFalse);
      expect(desktop, isFalse);
    });
  });
}
