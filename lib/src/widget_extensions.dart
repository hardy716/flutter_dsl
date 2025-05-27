import 'package:flutter/material.dart';

extension WidgetModifiers on Widget {
  Widget paddingAll(double value) => Padding(padding: EdgeInsets.all(value), child: this);

  Widget paddingSymmetric({double horizontal = 0, double vertical = 0}) => Padding(
    padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
    child: this,
  );

  Widget paddingOnly({double left = 0, double top = 0, double right = 0, double bottom = 0}) => Padding(
    padding: EdgeInsets.only(left: left, top: top, right: right, bottom: bottom),
    child: this,
  );

  Widget marginAll(double value) => Container(margin: EdgeInsets.all(value), child: this);

  Widget marginSymmetric({double horizontal = 0, double vertical = 0}) => Container(
    margin: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
    child: this,
  );

  Widget marginOnly({double left = 0, double top = 0, double right = 0, double bottom = 0}) => Container(
    padding: EdgeInsets.only(left: left, top: top, right: right, bottom: bottom),
    child: this,
  );

  Widget center() => Center(child: this);

  Widget align(Alignment alignment) => Align(alignment: alignment, child: this);

  Widget rounded(double radius) => ClipRRect(borderRadius: BorderRadius.circular(radius), child: this);

  Widget backgroundColor(Color color) => Container(color: color, child: this);

  Widget onTap(VoidCallback onTap, {HitTestBehavior behavior = HitTestBehavior.opaque}) =>
      GestureDetector(onTap: onTap, behavior: behavior, child: this);
}
