import 'package:flutter/widgets.dart';

import 'responsive_scope.dart';
import 'screen_size.dart';

/// Builds a different widget for mobile / tablet / desktop.
///
/// [mobile] is required. Larger size builders fall through to the next-smaller
/// available builder: a desktop-sized screen with only [mobile] supplied uses
/// [mobile]; a tablet-sized screen with only [desktop] supplied uses [mobile].
///
/// ```dart
/// ResponsiveBuilder(
///   mobile: (c) => const MobileLayout(),
///   tablet: (c) => const TabletLayout(),
///   desktop: (c) => const DesktopLayout(),
/// );
/// ```
class ResponsiveBuilder extends StatelessWidget {
  /// Builder used when the current [ScreenSize] is mobile (or a larger size
  /// has no builder).
  final WidgetBuilder mobile;

  /// Builder used when the current [ScreenSize] is tablet.
  final WidgetBuilder? tablet;

  /// Builder used when the current [ScreenSize] is desktop.
  final WidgetBuilder? desktop;

  /// Creates a responsive builder. [mobile] is required.
  const ResponsiveBuilder({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    final size = ResponsiveScope.of(context);
    if (size.isDesktop) {
      return (desktop ?? tablet ?? mobile)(context);
    }
    if (size.isTablet) {
      return (tablet ?? mobile)(context);
    }
    return mobile(context);
  }
}
