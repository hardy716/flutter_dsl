import 'package:flutter/widgets.dart';

import 'breakpoints.dart';
import 'responsive_scope.dart';
import 'screen_size.dart';

/// Base class that turns the declarative [`@ResponsiveView`](ResponsiveView)
/// marker into actual runtime behavior.
///
/// Subclasses implement [buildResponsive] instead of `build`. The base class
/// automatically wraps the result in a [ResponsiveScope] so that the configured
/// [breakpoints] take effect for the subtree, and forwards the current
/// [ScreenSize] to the builder.
///
/// ```dart
/// @ResponsiveView(breakpoints: [400, 800, 1200, 1600])
/// class Dashboard extends ResponsiveStatelessWidget {
///   const Dashboard({super.key})
///     : super(breakpoints: const [400, 800, 1200, 1600]);
///
///   @override
///   Widget buildResponsive(BuildContext context, ScreenSize size) {
///     return size.isMobile ? const _MobileDashboard() : const _WideDashboard();
///   }
/// }
/// ```
///
/// The `breakpoints` you pass to the annotation and to `super(...)` should
/// match — keeping them in sync is the developer's responsibility.
abstract class ResponsiveStatelessWidget extends StatelessWidget {
  /// Breakpoints used to wrap this subtree in a [ResponsiveScope].
  final List<int> breakpoints;

  /// Creates a responsive stateless widget. Subclasses typically pass the same
  /// list as the matching `@ResponsiveView` annotation.
  const ResponsiveStatelessWidget({
    super.key,
    this.breakpoints = Breakpoints.material3,
  });

  /// Build the subtree given the current [ScreenSize].
  Widget buildResponsive(BuildContext context, ScreenSize size);

  @override
  Widget build(BuildContext context) {
    return ResponsiveScope(
      breakpoints: breakpoints,
      child: Builder(
        builder: (ctx) => buildResponsive(ctx, ResponsiveScope.of(ctx)),
      ),
    );
  }
}

/// Stateful counterpart of [ResponsiveStatelessWidget]. Pair with
/// [ResponsiveState] in the subclass.
abstract class ResponsiveStatefulWidget extends StatefulWidget {
  /// Breakpoints used to wrap this subtree in a [ResponsiveScope].
  final List<int> breakpoints;

  /// Creates a responsive stateful widget.
  const ResponsiveStatefulWidget({
    super.key,
    this.breakpoints = Breakpoints.material3,
  });
}

/// Base [State] for [ResponsiveStatefulWidget] subclasses. Implement
/// [buildResponsive] instead of `build`; the wrapping in [ResponsiveScope]
/// is handled here.
abstract class ResponsiveState<T extends ResponsiveStatefulWidget>
    extends State<T> {
  /// Build the subtree given the current [ScreenSize].
  Widget buildResponsive(BuildContext context, ScreenSize size);

  @override
  Widget build(BuildContext context) {
    return ResponsiveScope(
      breakpoints: widget.breakpoints,
      child: Builder(
        builder: (ctx) => buildResponsive(ctx, ResponsiveScope.of(ctx)),
      ),
    );
  }
}
