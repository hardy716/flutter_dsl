import 'package:meta/meta.dart';

/// Declarative marker that announces a widget as part of a design system.
///
/// Like [ResponsiveView] this is a marker only — it does not change runtime
/// behavior. Use it to make design-system membership visible to readers,
/// IDE search, and inventory tooling.
///
/// ```dart
/// @DesignSystemComponent(name: 'PrimaryButton', category: 'actions')
/// class PrimaryButton extends StatelessWidget { ... }
/// ```
@immutable
@Target({TargetKind.classType})
class DesignSystemComponent {
  /// Human-readable name of the component (e.g. `'PrimaryButton'`).
  final String? name;

  /// Logical grouping (e.g. `'actions'`, `'feedback'`, `'navigation'`).
  final String? category;

  /// Creates a design-system membership marker.
  const DesignSystemComponent({this.name, this.category});
}
