import 'package:flutter/material.dart';

/// Extension on `Iterable<Widget>` to convert into Row or Column with DSL-style syntax.
extension IterableWidgetExtensions on Iterable<Widget> {
  /// Converts the list of widgets into a [Row].
  ///
  /// ```dart
  /// [Text('A'), Text('B')].row()
  /// ```
  Widget row({
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    MainAxisSize mainAxisSize = MainAxisSize.max,
    double spacing = 0.0,
  }) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      spacing: spacing,
      children: toList(),
    );
  }

  /// Converts the list of widgets into a [Column].
  ///
  /// ```dart
  /// [Text('A'), Text('B')].column()
  /// ```
  Widget column({
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    MainAxisSize mainAxisSize = MainAxisSize.max,
    double spacing = 0.0,
  }) {
    return Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      spacing: spacing,
      children: toList(),
    );
  }
}
