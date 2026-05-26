import 'package:flutter/material.dart';

/// Deprecated margin helpers extracted from the original `WidgetExtensions`.
/// These wrap the widget in a [Container] just to apply a margin, which is
/// rarely the right abstraction in modern Flutter UIs.
///
/// **Status**: Deprecated in v1.0, scheduled for removal in v2.0. Prefer
/// `paddingAll` / `paddingSymmetric` / `paddingOnly` on the parent layout, or
/// insert a `Spacing` widget between siblings.
extension DeprecatedWidgetMarginExtensions on Widget {
  /// Adds uniform margin to all sides using a wrapping [Container].
  @Deprecated(
    'Deprecated in v1.0. Use `paddingAll` on the parent or a `Spacing` widget '
    'in the sibling list instead. Will be removed in v2.0.',
  )
  Widget marginAll(double value) =>
      Container(margin: EdgeInsets.all(value), child: this);

  /// Adds symmetric horizontal and vertical margin using a wrapping [Container].
  @Deprecated(
    'Deprecated in v1.0. Use `paddingSymmetric` or a `Spacing` widget instead. '
    'Will be removed in v2.0.',
  )
  Widget marginSymmetric({double horizontal = 0, double vertical = 0}) =>
      Container(
        margin:
            EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
        child: this,
      );

  /// Adds directional margin (left, top, right, bottom) using a wrapping [Container].
  @Deprecated(
    'Deprecated in v1.0. Use `paddingOnly` or a `Spacing` widget instead. '
    'Will be removed in v2.0.',
  )
  Widget marginOnly({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) =>
      Container(
        margin:
            EdgeInsets.only(left: left, top: top, right: right, bottom: bottom),
        child: this,
      );
}
