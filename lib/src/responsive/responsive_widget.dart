import 'package:flutter/widgets.dart';

import 'breakpoints.dart';
import 'responsive_scope.dart';
import 'screen_size.dart';

/// Base class that turns the declarative [`@ResponsiveView`](ResponsiveView)
/// marker into actual runtime behavior.
///
/// Subclasses implement [buildResponsive] instead of `build`. The base class
/// resolves the current [ScreenSize] from the nearest [ResponsiveScope] and
/// forwards it to the builder.
///
/// Configure breakpoints **once** at the app level via a single
/// [ResponsiveScope] (typically in `MaterialApp.builder`); every responsive
/// widget below it then shares the same configuration. Mark the view with
/// `@ResponsiveView()` for readability/tooling — the marker has no runtime
/// effect on its own.
///
/// ```dart
/// MaterialApp(
///   builder: (context, child) =>
///       ResponsiveScope(breakpoints: const [400, 800, 1200, 1600], child: child!),
///   home: const Dashboard(),
/// );
///
/// @ResponsiveView()
/// class Dashboard extends ResponsiveStatelessWidget {
///   const Dashboard({super.key});
///
///   @override
///   Widget buildResponsive(BuildContext context, ScreenSize size) {
///     return size.isMobile ? const _MobileDashboard() : const _WideDashboard();
///   }
/// }
/// ```
abstract class ResponsiveStatelessWidget extends StatelessWidget {
  /// Breakpoints used to wrap this subtree in a [ResponsiveScope].
  final List<int> breakpoints;

  /// Creates a responsive stateless widget.
  ///
  /// Prefer configuring breakpoints once on the app-level [ResponsiveScope]
  /// instead of per widget.
  const ResponsiveStatelessWidget({
    super.key,
    @Deprecated(
      'Set breakpoints once on the app-level ResponsiveScope instead of per '
      'widget. This parameter is a no-op duplicate of the scope config and '
      'will be removed in 2.0.',
    )
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
  ///
  /// Prefer configuring breakpoints once on the app-level [ResponsiveScope]
  /// instead of per widget.
  const ResponsiveStatefulWidget({
    super.key,
    @Deprecated(
      'Set breakpoints once on the app-level ResponsiveScope instead of per '
      'widget. This parameter is a no-op duplicate of the scope config and '
      'will be removed in 2.0.',
    )
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
