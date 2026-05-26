import 'package:flutter/widgets.dart';

import 'responsive_scope.dart';
import 'screen_size.dart';

/// Chainable responsive helpers on [Widget].
///
/// Each method returns a thin wrapper widget that reads [ResponsiveScope]
/// at build time. The wrappers add one node to the tree; for hot paths where
/// that matters, prefer `Responsive.value` / `Responsive.when` in
/// `responsive_helpers.dart`, which take a [BuildContext] directly and add no
/// nodes.
extension ResponsiveWidgetExtensions on Widget {
  /// Applies [transform] only on mobile-sized screens. Returns `this` otherwise.
  Widget onMobile(Widget Function(Widget w) transform) =>
      _ResponsiveTransform(when: (s) => s.isMobile, transform: transform, child: this);

  /// Applies [transform] only on tablet-sized screens.
  Widget onTablet(Widget Function(Widget w) transform) =>
      _ResponsiveTransform(when: (s) => s.isTablet, transform: transform, child: this);

  /// Applies [transform] only on desktop-sized screens.
  Widget onDesktop(Widget Function(Widget w) transform) =>
      _ResponsiveTransform(when: (s) => s.isDesktop, transform: transform, child: this);

  /// Hides the widget on mobile (returns [SizedBox.shrink]).
  Widget hideOnMobile() =>
      _ResponsiveVisibility(when: (s) => !s.isMobile, child: this);

  /// Hides the widget on tablet.
  Widget hideOnTablet() =>
      _ResponsiveVisibility(when: (s) => !s.isTablet, child: this);

  /// Hides the widget on desktop.
  Widget hideOnDesktop() =>
      _ResponsiveVisibility(when: (s) => !s.isDesktop, child: this);

  /// Picks a transform per size in a single call. Sizes with no transform
  /// supplied return the widget unchanged.
  Widget responsive({
    Widget Function(Widget w)? mobile,
    Widget Function(Widget w)? tablet,
    Widget Function(Widget w)? desktop,
  }) =>
      _ResponsiveSwitch(
        mobile: mobile,
        tablet: tablet,
        desktop: desktop,
        child: this,
      );
}

class _ResponsiveTransform extends StatelessWidget {
  final Widget child;
  final bool Function(ScreenSize) when;
  final Widget Function(Widget) transform;

  const _ResponsiveTransform({
    required this.child,
    required this.when,
    required this.transform,
  });

  @override
  Widget build(BuildContext context) {
    final size = ResponsiveScope.of(context);
    return when(size) ? transform(child) : child;
  }
}

class _ResponsiveVisibility extends StatelessWidget {
  final Widget child;
  final bool Function(ScreenSize) when;

  const _ResponsiveVisibility({required this.child, required this.when});

  @override
  Widget build(BuildContext context) {
    final size = ResponsiveScope.of(context);
    return when(size) ? child : const SizedBox.shrink();
  }
}

class _ResponsiveSwitch extends StatelessWidget {
  final Widget child;
  final Widget Function(Widget)? mobile;
  final Widget Function(Widget)? tablet;
  final Widget Function(Widget)? desktop;

  const _ResponsiveSwitch({
    required this.child,
    this.mobile,
    this.tablet,
    this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    final size = ResponsiveScope.of(context);
    if (size.isDesktop && desktop != null) return desktop!(child);
    if (size.isTablet && tablet != null) return tablet!(child);
    if (size.isMobile && mobile != null) return mobile!(child);
    return child;
  }
}
