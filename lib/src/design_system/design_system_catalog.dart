import 'package:flutter/widgets.dart';

/// A single entry in the [DesignSystemCatalog].
@immutable
class DesignSystemEntry {
  /// Human-readable component name (e.g. `'PrimaryButton'`).
  final String name;

  /// Optional logical grouping (e.g. `'actions'`).
  final String? category;

  /// Builds a preview/instance of the component.
  final WidgetBuilder builder;

  /// Creates a catalog entry.
  const DesignSystemEntry({
    required this.name,
    required this.builder,
    this.category,
  });
}

/// A lightweight, opt-in runtime registry that gives the
/// `@DesignSystemComponent` marker something to do: build an in-app component
/// gallery / storybook without any code generation.
///
/// The annotation documents membership for readers and IDE search; a matching
/// [register] call makes the component enumerable at runtime:
///
/// ```dart
/// @DesignSystemComponent(name: 'PrimaryButton', category: 'actions')
/// class PrimaryButton extends StatelessWidget { ... }
///
/// // e.g. in a `registerComponents()` you call at startup:
/// DesignSystemCatalog.register(
///   name: 'PrimaryButton',
///   category: 'actions',
///   builder: (_) => const PrimaryButton(),
/// );
///
/// // then render a gallery:
/// for (final e in DesignSystemCatalog.entries) GalleryTile(entry: e),
/// ```
class DesignSystemCatalog {
  DesignSystemCatalog._();

  static final List<DesignSystemEntry> _entries = [];

  /// Registers (or replaces) a component by `(name, category)`. Idempotent, so
  /// it is safe to call again across hot reloads.
  static void register({
    required String name,
    required WidgetBuilder builder,
    String? category,
  }) {
    _entries.removeWhere((e) => e.name == name && e.category == category);
    _entries.add(
      DesignSystemEntry(name: name, category: category, builder: builder),
    );
  }

  /// All registered entries, in registration order.
  static List<DesignSystemEntry> get entries => List.unmodifiable(_entries);

  /// Entries grouped by category (uncategorized entries fall under
  /// `'uncategorized'`).
  static Map<String, List<DesignSystemEntry>> get byCategory {
    final map = <String, List<DesignSystemEntry>>{};
    for (final e in _entries) {
      (map[e.category ?? 'uncategorized'] ??= []).add(e);
    }
    return map;
  }

  /// Removes all entries. Primarily useful for tests.
  static void clear() => _entries.clear();
}
