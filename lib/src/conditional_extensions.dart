import 'package:flutter/material.dart';

/// Extension methods for conditionally rendering widgets in a declarative way.
///
/// These methods allow concise conditional logic directly on widgets:
/// ```dart
/// Text('Visible').visible(isShown);
/// 'Hello'.text().ifTrue(condition);
/// 'Hello'.text().ifFalse(condition, orElse: () => 'Fallback'.text());
/// ```
extension ConditionalExtensions on Widget {
  /// Shows the widget only if [condition] is true.
  /// Otherwise, returns an empty [SizedBox.shrink()].
  ///
  /// ```dart
  /// Icon(Icons.star).visible(isFavorite);
  /// ```
  Widget visible(bool condition) => condition ? this : const SizedBox.shrink();

  /// Shows the widget if [condition] is true.
  /// Otherwise, shows the result of [orElse] if provided, or an empty [SizedBox].
  ///
  /// ```dart
  /// 'Success'.text().ifTrue(isLoggedIn, orElse: () => 'Login required'.text());
  /// ```
  Widget ifTrue(bool condition, {Widget Function()? orElse}) =>
      condition ? this : (orElse?.call() ?? const SizedBox.shrink());

  /// Shows the widget if [condition] is false.
  /// Otherwise, shows the result of [orElse] if provided, or an empty [SizedBox].
  ///
  /// ```dart
  /// 'Offline mode'.text().ifFalse(isConnected);
  /// ```
  Widget ifFalse(bool condition, {Widget Function()? orElse}) =>
      !condition ? this : (orElse?.call() ?? const SizedBox.shrink());
}