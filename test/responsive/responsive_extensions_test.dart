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

const _markerKey = Key('marker');
const _wrappedKey = Key('wrapped');

ColoredBox _wrap1(Widget w) => ColoredBox(
      key: _wrappedKey,
      color: const Color(0xFF000000),
      child: w,
    );

void main() {
  group('.onMobile / .onTablet / .onDesktop', () {
    testWidgets('.onMobile transforms on mobile', (tester) async {
      await tester.pumpWidget(
        _wrap(
          const Size(400, 800),
          const SizedBox(key: _markerKey).onMobile(_wrap1),
        ),
      );
      expect(find.byKey(_wrappedKey), findsOneWidget);
    });

    testWidgets('.onMobile does not transform on desktop', (tester) async {
      await tester.pumpWidget(
        _wrap(
          const Size(1400, 800),
          const SizedBox(key: _markerKey).onMobile(_wrap1),
        ),
      );
      expect(find.byKey(_wrappedKey), findsNothing);
      expect(find.byKey(_markerKey), findsOneWidget);
    });

    testWidgets('.onTablet transforms on medium', (tester) async {
      await tester.pumpWidget(
        _wrap(
          const Size(800, 600),
          const SizedBox(key: _markerKey).onTablet(_wrap1),
        ),
      );
      expect(find.byKey(_wrappedKey), findsOneWidget);
    });

    testWidgets('.onTablet transforms on expanded', (tester) async {
      await tester.pumpWidget(
        _wrap(
          const Size(1000, 700),
          const SizedBox(key: _markerKey).onTablet(_wrap1),
        ),
      );
      expect(find.byKey(_wrappedKey), findsOneWidget);
    });

    testWidgets('.onTablet does not transform on mobile', (tester) async {
      await tester.pumpWidget(
        _wrap(
          const Size(400, 800),
          const SizedBox(key: _markerKey).onTablet(_wrap1),
        ),
      );
      expect(find.byKey(_wrappedKey), findsNothing);
    });

    testWidgets('.onDesktop transforms on large', (tester) async {
      await tester.pumpWidget(
        _wrap(
          const Size(1400, 800),
          const SizedBox(key: _markerKey).onDesktop(_wrap1),
        ),
      );
      expect(find.byKey(_wrappedKey), findsOneWidget);
    });
  });

  group('.hideOnMobile / .hideOnTablet / .hideOnDesktop', () {
    testWidgets('.hideOnMobile shrinks on mobile', (tester) async {
      await tester.pumpWidget(
        _wrap(
          const Size(400, 800),
          const SizedBox(key: _markerKey, width: 100, height: 100)
              .hideOnMobile(),
        ),
      );
      expect(find.byKey(_markerKey), findsNothing);
    });

    testWidgets('.hideOnMobile shows on desktop', (tester) async {
      await tester.pumpWidget(
        _wrap(
          const Size(1400, 800),
          const SizedBox(key: _markerKey, width: 100, height: 100)
              .hideOnMobile(),
        ),
      );
      expect(find.byKey(_markerKey), findsOneWidget);
    });

    testWidgets('.hideOnTablet shrinks on tablet', (tester) async {
      await tester.pumpWidget(
        _wrap(
          const Size(800, 600),
          const SizedBox(key: _markerKey, width: 100, height: 100)
              .hideOnTablet(),
        ),
      );
      expect(find.byKey(_markerKey), findsNothing);
    });

    testWidgets('.hideOnTablet shows on mobile', (tester) async {
      await tester.pumpWidget(
        _wrap(
          const Size(400, 800),
          const SizedBox(key: _markerKey, width: 100, height: 100)
              .hideOnTablet(),
        ),
      );
      expect(find.byKey(_markerKey), findsOneWidget);
    });

    testWidgets('.hideOnDesktop shrinks on desktop', (tester) async {
      await tester.pumpWidget(
        _wrap(
          const Size(1400, 800),
          const SizedBox(key: _markerKey, width: 100, height: 100)
              .hideOnDesktop(),
        ),
      );
      expect(find.byKey(_markerKey), findsNothing);
    });

    testWidgets('.hideOnDesktop shows on mobile', (tester) async {
      await tester.pumpWidget(
        _wrap(
          const Size(400, 800),
          const SizedBox(key: _markerKey, width: 100, height: 100)
              .hideOnDesktop(),
        ),
      );
      expect(find.byKey(_markerKey), findsOneWidget);
    });
  });

  group('.responsive', () {
    ColoredBox tag(String key) =>
        ColoredBox(key: Key(key), color: const Color(0xFF000000));
    Widget Function(Widget) wrapAs(String key) => (w) => ColoredBox(
          key: Key(key),
          color: const Color(0xFF000000),
          child: w,
        );

    testWidgets('picks mobile transform on mobile', (tester) async {
      await tester.pumpWidget(
        _wrap(
          const Size(400, 800),
          const SizedBox(key: _markerKey).responsive(
            mobile: wrapAs('mobile'),
            tablet: wrapAs('tablet'),
            desktop: wrapAs('desktop'),
          ),
        ),
      );
      expect(find.byKey(const Key('mobile')), findsOneWidget);
    });

    testWidgets('picks tablet transform on tablet', (tester) async {
      await tester.pumpWidget(
        _wrap(
          const Size(800, 600),
          const SizedBox(key: _markerKey).responsive(
            mobile: wrapAs('mobile'),
            tablet: wrapAs('tablet'),
            desktop: wrapAs('desktop'),
          ),
        ),
      );
      expect(find.byKey(const Key('tablet')), findsOneWidget);
    });

    testWidgets('picks desktop transform on desktop', (tester) async {
      await tester.pumpWidget(
        _wrap(
          const Size(1400, 800),
          const SizedBox(key: _markerKey).responsive(
            mobile: wrapAs('mobile'),
            tablet: wrapAs('tablet'),
            desktop: wrapAs('desktop'),
          ),
        ),
      );
      expect(find.byKey(const Key('desktop')), findsOneWidget);
    });

    testWidgets('omitted transform falls through to original on that size',
        (tester) async {
      await tester.pumpWidget(
        _wrap(
          const Size(800, 600),
          const SizedBox(key: _markerKey).responsive(
            mobile: wrapAs('mobile'),
            // tablet omitted
            desktop: wrapAs('desktop'),
          ),
        ),
      );
      // On tablet, no wrapper is applied; original marker remains.
      expect(find.byKey(_markerKey), findsOneWidget);
      expect(find.byKey(const Key('tablet')), findsNothing);
      // Sanity: tag is created const-eligible (suppresses unused warning).
      expect(tag('unused').color, const Color(0xFF000000));
    });
  });
}
