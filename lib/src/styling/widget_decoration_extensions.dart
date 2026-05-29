import 'package:flutter/widgets.dart';

/// A single-node alternative to chaining several styling wrappers.
///
/// Each individual styling extension (`.paddingAll`, `.backgroundColor`,
/// `.rounded`, …) adds one wrapper widget. Chaining three or four of them
/// trades deep nesting for a long chain and a correspondingly deep widget
/// tree. [box] collapses padding, background, border, corner radius, shadow,
/// and clipping into a **single** [Container], keeping the tree shallow and
/// the widget inspector readable.
///
/// ```dart
/// // 3 wrapper nodes:
/// Text('hi').paddingAll(12).backgroundColor(c).rounded(8);
///
/// // 1 node, same result:
/// Text('hi').box(padding: const EdgeInsets.all(12), color: c, radius: 8);
/// ```
extension WidgetDecorationExtensions on Widget {
  /// Wraps the widget in a single [Container] that applies any combination of
  /// [padding], [color] (or [gradient]), [border], corner radius
  /// ([radius] sugar for [BorderRadius.circular], or full [borderRadius]),
  /// and [boxShadow].
  ///
  /// When a corner radius is supplied the child is clipped using
  /// [clipBehavior]; otherwise no clip is applied. [gradient] takes precedence
  /// over [color] when both are given.
  Widget box({
    EdgeInsetsGeometry? padding,
    Color? color,
    Gradient? gradient,
    BoxBorder? border,
    double? radius,
    BorderRadiusGeometry? borderRadius,
    List<BoxShadow>? boxShadow,
    Clip clipBehavior = Clip.antiAlias,
  }) {
    final resolvedRadius = borderRadius ??
        (radius != null ? BorderRadius.circular(radius) : null);
    final hasDecoration = color != null ||
        gradient != null ||
        border != null ||
        resolvedRadius != null ||
        boxShadow != null;
    return Container(
      padding: padding,
      clipBehavior: resolvedRadius != null ? clipBehavior : Clip.none,
      decoration: hasDecoration
          ? BoxDecoration(
              color: color,
              gradient: gradient,
              border: border,
              borderRadius: resolvedRadius,
              boxShadow: boxShadow,
            )
          : null,
      child: this,
    );
  }
}
