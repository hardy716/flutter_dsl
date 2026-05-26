import 'package:flutter/widgets.dart';

/// Visibility helper for conditional rendering.
///
/// ```dart
/// Icon(Icons.star).visible(isFavorite);
/// ```
///
/// For *transforming* the widget on a condition (rather than gating
/// visibility), see [FunctionalConditionalExtensions.onTrue] /
/// [FunctionalConditionalExtensions.onFalse].
extension ConditionalExtensions on Widget {
  /// Shows the widget only if [condition] is true.
  /// Otherwise, returns an empty [SizedBox.shrink()].
  ///
  /// ```dart
  /// Icon(Icons.star).visible(isFavorite);
  /// ```
  Widget visible(bool condition) => condition ? this : const SizedBox.shrink();
}
