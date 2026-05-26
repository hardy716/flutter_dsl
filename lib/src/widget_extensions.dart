import 'package:flutter/material.dart';

/// Provides chainable extension methods for `Widget` to write Flutter UI in a more declarative and readable way.
extension WidgetExtensions on Widget {
  /// Adds uniform padding to all sides of the widget.
  ///
  /// ```dart
  /// Text('Hello').paddingAll(16);
  /// ```
  Widget paddingAll(double value) =>
      Padding(padding: EdgeInsets.all(value), child: this);

  /// Adds horizontal and vertical symmetric padding to the widget.
  ///
  /// ```dart
  /// Text('Hello').paddingSymmetric(horizontal: 12, vertical: 8);
  /// ```
  Widget paddingSymmetric({double horizontal = 0, double vertical = 0}) =>
      Padding(
        padding:
            EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
        child: this,
      );

  /// Adds directional padding to the widget (left, top, right, bottom).
  ///
  /// ```dart
  /// Text('Hello').paddingOnly(left: 8, top: 4);
  /// ```
  Widget paddingOnly({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) =>
      Padding(
        padding:
            EdgeInsets.only(left: left, top: top, right: right, bottom: bottom),
        child: this,
      );

  /// Wraps the widget in a [Center] widget.
  ///
  /// ```dart
  /// Text('Centered').center();
  /// ```
  Widget center() => Center(child: this);

  /// Wraps the widget in an [Align] with a given alignment.
  ///
  /// ```dart
  /// Text('Right Aligned').align(Alignment.centerRight);
  /// ```
  Widget align(Alignment alignment) => Align(alignment: alignment, child: this);

  /// Wraps this widget with an [Expanded] widget.
  ///
  /// ```dart
  /// Text('Expanded').expanded()
  /// ```
  Widget expanded() => Expanded(child: this);

  /// Wraps this widget with a [Flexible] widget using the given [flex] and [fit].
  ///
  /// ```dart
  /// Text('Flexible').flex(2)
  /// ```
  Widget flex(int flex, {FlexFit fit = FlexFit.loose}) =>
      Flexible(flex: flex, fit: fit, child: this);

  /// Clips the widget with a rounded [BorderRadius.circular].
  ///
  /// ```dart
  /// Image.asset('img.png').rounded(12);
  /// ```
  Widget rounded(double radius) =>
      ClipRRect(borderRadius: BorderRadius.circular(radius), child: this);

  /// Paints a solid background color behind the widget using a [ColoredBox].
  ///
  /// For richer surfaces (gradients, borders, shadows) compose a
  /// [DecoratedBox] or [Material] directly.
  Widget backgroundColor(Color color) => ColoredBox(color: color, child: this);

  /// Wraps the widget in a [GestureDetector] to handle tap events.
  ///
  /// ```dart
  /// Text('Tap me').onTap(() => print('Tapped!'));
  /// ```
  Widget onTap(
    VoidCallback onTap, {
    HitTestBehavior behavior = HitTestBehavior.opaque,
  }) =>
      GestureDetector(onTap: onTap, behavior: behavior, child: this);
}
