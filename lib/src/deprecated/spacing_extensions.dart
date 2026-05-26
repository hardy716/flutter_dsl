import 'package:flutter/widgets.dart';

/// Deprecated chainable gap helpers extracted from the original
/// `spacing_extensions.dart`. Each call implicitly wraps the widget in a
/// [Row] or [Column], which collides when chained
/// (e.g. `.gapRight(8).gapBottom(16)` nests a [Column] inside a [Row]).
///
/// **Status**: Deprecated in v1.0, scheduled for removal in v2.0. Prefer
/// `Iterable<Widget>.row(spacing: ...)` / `.column(spacing: ...)` from
/// `iterable_widget_extensions.dart`, or insert a `Spacing` widget between
/// siblings.
@Deprecated(
  'Deprecated in v1.0. Implicit Row/Column wrapping collides when chained. '
  'Use Iterable<Widget>.row(spacing: ...) / .column(spacing: ...) or the '
  'Spacing widget on the parent layout. Will be removed in v2.0.',
)
extension SpacingExtensions on Widget {
  /// Adds horizontal spacing to the **right** of the widget using a [Row].
  ///
  /// ```dart
  /// Icon(Icons.star).gapRight(8);
  /// ```
  Widget gapRight(double width) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          this,
          SizedBox(width: width),
        ],
      );

  /// Adds horizontal spacing to the **left** of the widget using a [Row].
  ///
  /// ```dart
  /// Icon(Icons.star).gapLeft(8);
  /// ```
  Widget gapLeft(double width) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(width: width),
          this,
        ],
      );

  /// Adds vertical spacing to the **bottom** of the widget using a [Column].
  ///
  /// ```dart
  /// Text('Hello').gapBottom(16);
  /// ```
  Widget gapBottom(double height) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          this,
          SizedBox(height: height),
        ],
      );

  /// Adds vertical spacing to the **top** of the widget using a [Column].
  ///
  /// ```dart
  /// Text('Hello').gapTop(16);
  /// ```
  Widget gapTop(double height) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: height),
          this,
        ],
      );
}
