import 'package:flutter/widgets.dart';

import 'responsive_scope.dart';

/// Static helpers that read the responsive environment from a [BuildContext]
/// without adding wrapper widgets to the tree.
///
/// Use these in a `build` method when you want immediate evaluation and zero
/// tree depth. For chainable transforms on a widget value, use the
/// `.onMobile` / `.onDesktop` / `.responsive` extensions instead.
///
/// ```dart
/// Padding(
///   padding: EdgeInsets.all(
///     Responsive.value(context, mobile: 8.0, desktop: 24.0),
///   ),
///   child: ...
/// );
/// ```
class Responsive {
  Responsive._();

  /// Picks a value per screen size. Falls back from `desktop` to `tablet` to
  /// `mobile` when a larger bucket has no explicit value.
  static T value<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    final size = ResponsiveScope.of(context);
    if (size.isDesktop) return desktop ?? tablet ?? mobile;
    if (size.isTablet) return tablet ?? mobile;
    return mobile;
  }

  /// Picks a widget per screen size — a zero-wrapper alternative to
  /// [`ResponsiveBuilder`](ResponsiveBuilder) when the widgets are cheap to
  /// construct unconditionally.
  static Widget when(
    BuildContext context, {
    required Widget mobile,
    Widget? tablet,
    Widget? desktop,
  }) {
    final size = ResponsiveScope.of(context);
    if (size.isDesktop) return desktop ?? tablet ?? mobile;
    if (size.isTablet) return tablet ?? mobile;
    return mobile;
  }

  /// Whether the current screen is mobile-sized.
  static bool isMobile(BuildContext context) =>
      ResponsiveScope.of(context).isMobile;

  /// Whether the current screen is tablet-sized.
  static bool isTablet(BuildContext context) =>
      ResponsiveScope.of(context).isTablet;

  /// Whether the current screen is desktop-sized.
  static bool isDesktop(BuildContext context) =>
      ResponsiveScope.of(context).isDesktop;
}
