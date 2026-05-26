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
  group('ResponsiveBuilder primary branches', () {
    testWidgets('uses mobile on compact', (tester) async {
      await tester.pumpWidget(
        _wrap(
          const Size(400, 800),
          ResponsiveBuilder(
            mobile: (_) => const SizedBox(key: Key('m')),
            tablet: (_) => const SizedBox(key: Key('t')),
            desktop: (_) => const SizedBox(key: Key('d')),
          ),
        ),
      );
      expect(find.byKey(const Key('m')), findsOneWidget);
    });

    testWidgets('uses tablet on medium', (tester) async {
      await tester.pumpWidget(
        _wrap(
          const Size(800, 600),
          ResponsiveBuilder(
            mobile: (_) => const SizedBox(key: Key('m')),
            tablet: (_) => const SizedBox(key: Key('t')),
            desktop: (_) => const SizedBox(key: Key('d')),
          ),
        ),
      );
      expect(find.byKey(const Key('t')), findsOneWidget);
    });

    testWidgets('uses desktop on large', (tester) async {
      await tester.pumpWidget(
        _wrap(
          const Size(1400, 800),
          ResponsiveBuilder(
            mobile: (_) => const SizedBox(key: Key('m')),
            tablet: (_) => const SizedBox(key: Key('t')),
            desktop: (_) => const SizedBox(key: Key('d')),
          ),
        ),
      );
      expect(find.byKey(const Key('d')), findsOneWidget);
    });
  });

  group('ResponsiveBuilder fallback chain', () {
    testWidgets('desktop falls back to tablet when desktop is absent',
        (tester) async {
      await tester.pumpWidget(
        _wrap(
          const Size(1400, 800),
          ResponsiveBuilder(
            mobile: (_) => const SizedBox(key: Key('m')),
            tablet: (_) => const SizedBox(key: Key('t')),
            // desktop omitted
          ),
        ),
      );
      expect(find.byKey(const Key('t')), findsOneWidget);
    });

    testWidgets('desktop falls back to mobile when desktop and tablet absent',
        (tester) async {
      await tester.pumpWidget(
        _wrap(
          const Size(1400, 800),
          ResponsiveBuilder(
            mobile: (_) => const SizedBox(key: Key('m')),
            // tablet and desktop omitted
          ),
        ),
      );
      expect(find.byKey(const Key('m')), findsOneWidget);
    });

    testWidgets('tablet falls back to mobile when tablet is absent',
        (tester) async {
      await tester.pumpWidget(
        _wrap(
          const Size(800, 600),
          ResponsiveBuilder(
            mobile: (_) => const SizedBox(key: Key('m')),
            // tablet omitted
            desktop: (_) => const SizedBox(key: Key('d')),
          ),
        ),
      );
      expect(find.byKey(const Key('m')), findsOneWidget);
    });
  });
}
