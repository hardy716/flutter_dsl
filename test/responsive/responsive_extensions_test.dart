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

void main() {
  group('.onMobile / .onDesktop', () {
    testWidgets('transforms on mobile', (tester) async {
      await tester.pumpWidget(
        _wrap(
          const Size(400, 800),
          const SizedBox(key: _markerKey).onMobile(
            (w) => ColoredBox(
              key: _wrappedKey,
              color: const Color(0xFF000000),
              child: w,
            ),
          ),
        ),
      );
      expect(find.byKey(_wrappedKey), findsOneWidget);
    });

    testWidgets('does not transform on desktop', (tester) async {
      await tester.pumpWidget(
        _wrap(
          const Size(1400, 800),
          const SizedBox(key: _markerKey).onMobile(
            (w) => ColoredBox(
              key: _wrappedKey,
              color: const Color(0xFF000000),
              child: w,
            ),
          ),
        ),
      );
      expect(find.byKey(_wrappedKey), findsNothing);
      expect(find.byKey(_markerKey), findsOneWidget);
    });
  });

  group('.hideOnDesktop', () {
    testWidgets('shrinks on desktop', (tester) async {
      await tester.pumpWidget(
        _wrap(
          const Size(1400, 800),
          const SizedBox(key: _markerKey, width: 100, height: 100)
              .hideOnDesktop(),
        ),
      );
      expect(find.byKey(_markerKey), findsNothing);
    });

    testWidgets('shows on mobile', (tester) async {
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
    testWidgets('picks desktop transform on desktop', (tester) async {
      await tester.pumpWidget(
        _wrap(
          const Size(1400, 800),
          const SizedBox(key: _markerKey).responsive(
            mobile: (w) => ColoredBox(
              key: const Key('mobile'),
              color: const Color(0xFFFF0000),
              child: w,
            ),
            desktop: (w) => ColoredBox(
              key: const Key('desktop'),
              color: const Color(0xFF00FF00),
              child: w,
            ),
          ),
        ),
      );
      expect(find.byKey(const Key('desktop')), findsOneWidget);
      expect(find.byKey(const Key('mobile')), findsNothing);
    });
  });
}
