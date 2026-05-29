import 'package:flutter/widgets.dart';
import 'package:flutter_dsl/flutter_dsl.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(DesignSystemCatalog.clear);
  tearDown(DesignSystemCatalog.clear);

  test('register adds entries in order', () {
    DesignSystemCatalog.register(
      name: 'A',
      category: 'actions',
      builder: (_) => const SizedBox(),
    );
    DesignSystemCatalog.register(
      name: 'B',
      category: 'feedback',
      builder: (_) => const SizedBox(),
    );

    expect(DesignSystemCatalog.entries.map((e) => e.name), ['A', 'B']);
  });

  test('register is idempotent per (name, category)', () {
    DesignSystemCatalog.register(name: 'A', builder: (_) => const SizedBox());
    DesignSystemCatalog.register(name: 'A', builder: (_) => const SizedBox());
    expect(DesignSystemCatalog.entries, hasLength(1));
  });

  test('byCategory groups entries and defaults to uncategorized', () {
    DesignSystemCatalog.register(
      name: 'A',
      category: 'actions',
      builder: (_) => const SizedBox(),
    );
    DesignSystemCatalog.register(name: 'B', builder: (_) => const SizedBox());

    final grouped = DesignSystemCatalog.byCategory;
    expect(grouped['actions']!.map((e) => e.name), ['A']);
    expect(grouped['uncategorized']!.map((e) => e.name), ['B']);
  });

  testWidgets('entry builder renders the component', (tester) async {
    DesignSystemCatalog.register(
      name: 'Hello',
      builder: (_) => const Text('hello', textDirection: TextDirection.ltr),
    );
    final entry = DesignSystemCatalog.entries.single;
    await tester.pumpWidget(Builder(builder: entry.builder));
    expect(find.text('hello'), findsOneWidget);
  });
}
