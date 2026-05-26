import 'package:flutter/widgets.dart';

/// Deprecated visibility-style conditional helpers extracted from the original
/// `ConditionalExtensions`.
///
/// **Status**: Deprecated in v1.0, scheduled for removal in v2.0.
/// - For visibility, use `.visible(condition)`.
/// - For transforming the widget on a condition, use the new `.onTrue` /
///   `.onFalse` / `.when` helpers in `FunctionalConditionalExtensions`.
extension DeprecatedConditionalExtensions on Widget {
  /// Shows the widget if [condition] is true.
  /// Otherwise, shows the result of [orElse] if provided, or an empty [SizedBox].
  ///
  /// ```dart
  /// 'Success'.text().ifTrue(isLoggedIn, orElse: () => 'Login required'.text());
  /// ```
  @Deprecated(
    'Deprecated in v1.0. For visibility use `.visible(condition)`. For '
    'transforming the widget use `.onTrue(condition, transform)`. '
    'Will be removed in v2.0.',
  )
  Widget ifTrue(bool condition, {Widget Function()? orElse}) =>
      condition ? this : (orElse?.call() ?? const SizedBox.shrink());

  /// Shows the widget if [condition] is false.
  /// Otherwise, shows the result of [orElse] if provided, or an empty [SizedBox].
  ///
  /// ```dart
  /// 'Offline mode'.text().ifFalse(isConnected);
  /// ```
  @Deprecated(
    'Deprecated in v1.0. For visibility use `.visible(!condition)`. For '
    'transforming the widget use `.onFalse(condition, transform)`. '
    'Will be removed in v2.0.',
  )
  Widget ifFalse(bool condition, {Widget Function()? orElse}) =>
      !condition ? this : (orElse?.call() ?? const SizedBox.shrink());
}
