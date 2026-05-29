import 'package:flutter/widgets.dart';
import 'package:flutter_dsl/flutter_dsl.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('box collapses padding + color + radius into a single Container', () {
    const child = Text('hi', textDirection: TextDirection.ltr);
    final widget = child.box(
      padding: const EdgeInsets.all(12),
      color: const Color(0xFF112233),
      radius: 8,
    );

    expect(widget, isA<Container>());
    final container = widget as Container;
    expect(container.padding, const EdgeInsets.all(12));
    expect(container.clipBehavior, Clip.antiAlias);
    expect(container.child, same(child)); // exactly one wrapper, child untouched

    final decoration = container.decoration! as BoxDecoration;
    expect(decoration.color, const Color(0xFF112233));
    expect(decoration.borderRadius, BorderRadius.circular(8));
  });

  test('box without a radius adds no clip and no decoration', () {
    final widget =
        const Text('hi', textDirection: TextDirection.ltr).box(
      padding: const EdgeInsets.all(4),
    );
    final container = widget as Container;
    expect(container.decoration, isNull);
    expect(container.clipBehavior, Clip.none);
  });

  test('box prefers explicit borderRadius over the radius shorthand', () {
    final widget = const Text('hi', textDirection: TextDirection.ltr).box(
      radius: 8,
      borderRadius: const BorderRadius.all(Radius.circular(2)),
      color: const Color(0xFF000000),
    );
    final decoration = (widget as Container).decoration! as BoxDecoration;
    expect(decoration.borderRadius, const BorderRadius.all(Radius.circular(2)));
  });

  testWidgets('box renders its child inside one Container', (tester) async {
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: const Text('hello')
            .box(color: const Color(0xFF000000), radius: 4),
      ),
    );
    expect(find.text('hello'), findsOneWidget);
    expect(find.byType(Container), findsOneWidget);
  });
}
