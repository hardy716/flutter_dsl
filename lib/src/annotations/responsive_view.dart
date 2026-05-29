import 'package:meta/meta.dart';
import 'package:meta/meta_meta.dart';

/// Declarative marker that announces a widget as a responsive layout host.
///
/// This annotation documents intent — for readers, IDE search, and inventory
/// tooling — and pairs with a runtime counterpart rather than acting on its
/// own. By design the package uses no `dart:mirrors` or `build_runner`, so the
/// marker carries no runtime effect by itself; pair it with the base class
/// below to resolve a [ScreenSize].
///
/// Pair it with `extends ResponsiveStatelessWidget` (or
/// `ResponsiveStatefulWidget`) so the subtree resolves a [ScreenSize]. Configure
/// breakpoints **once** on the app-level `ResponsiveScope`, not here:
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
///   Widget buildResponsive(BuildContext context, ScreenSize size) { ... }
/// }
/// ```
@immutable
@Target({TargetKind.classType})
class ResponsiveView {
  /// Ascending list of four width thresholds in logical pixels.
  final List<int> breakpoints;

  /// Creates a marker for a responsive view.
  const ResponsiveView({
    @Deprecated(
      'Breakpoints are configured on the app-level ResponsiveScope, not on '
      'this marker (the annotation has no runtime effect). This parameter is '
      'removed in 2.0.',
    )
    this.breakpoints = const [600, 840, 1200, 1600],
  });
}
