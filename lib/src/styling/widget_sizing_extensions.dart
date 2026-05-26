import 'package:flutter/widgets.dart';

/// Compact sizing helpers that wrap the widget in [SizedBox],
/// [ConstrainedBox], or [AspectRatio].
extension WidgetSizingExtensions on Widget {
  /// Forces both [width] and [height] via [SizedBox].
  Widget size(double width, double height) =>
      SizedBox(width: width, height: height, child: this);

  /// Forces the width via [SizedBox].
  Widget width(double value) => SizedBox(width: value, child: this);

  /// Forces the height via [SizedBox].
  Widget height(double value) => SizedBox(height: value, child: this);

  /// Forces both width and height to the same [size].
  Widget square(double size) =>
      SizedBox(width: size, height: size, child: this);

  /// Applies [BoxConstraints] via [ConstrainedBox]. Unspecified bounds default
  /// to `0` (min) or [double.infinity] (max).
  Widget constrained({
    double minWidth = 0,
    double maxWidth = double.infinity,
    double minHeight = 0,
    double maxHeight = double.infinity,
  }) =>
      ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: minWidth,
          maxWidth: maxWidth,
          minHeight: minHeight,
          maxHeight: maxHeight,
        ),
        child: this,
      );

  /// Wraps the widget in an [AspectRatio].
  Widget aspectRatio(double ratio) =>
      AspectRatio(aspectRatio: ratio, child: this);
}
