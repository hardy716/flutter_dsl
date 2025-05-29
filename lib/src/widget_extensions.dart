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
        padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
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
        padding: EdgeInsets.only(left: left, top: top, right: right, bottom: bottom),
        child: this,
      );

  /// Adds uniform margin to all sides using a wrapping [Container].
  Widget marginAll(double value) =>
      Container(margin: EdgeInsets.all(value), child: this);

  /// Adds symmetric horizontal and vertical margin using a wrapping [Container].
  Widget marginSymmetric({double horizontal = 0, double vertical = 0}) =>
      Container(
        margin: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
        child: this,
      );

  /// Adds directional margin (left, top, right, bottom) using a wrapping [Container].
  Widget marginOnly({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) =>
      Container(
        margin: EdgeInsets.only(left: left, top: top, right: right, bottom: bottom),
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
  Widget align(Alignment alignment) =>
      Align(alignment: alignment, child: this);

  /// Clips the widget with a rounded [BorderRadius.circular].
  ///
  /// ```dart
  /// Image.asset('img.png').rounded(12);
  /// ```
  Widget rounded(double radius) =>
      ClipRRect(borderRadius: BorderRadius.circular(radius), child: this);

  /// Applies a background color to the widget using a wrapping [Container].
  Widget backgroundColor(Color color) =>
      Container(color: color, child: this);

  /// Wraps the widget in a [GestureDetector] to handle tap events.
  ///
  /// ```dart
  /// Text('Tap me').onTap(() => print('Tapped!'));
  /// ```
  Widget onTap(VoidCallback onTap, {HitTestBehavior behavior = HitTestBehavior.opaque}) =>
      GestureDetector(onTap: onTap, behavior: behavior, child: this);
}