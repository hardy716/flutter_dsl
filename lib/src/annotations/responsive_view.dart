import 'package:meta/meta.dart';
import 'package:meta/meta_meta.dart';

/// Declarative marker that announces a widget as a responsive layout host.
///
/// This annotation is a **marker, not magic**. Dart cannot read annotation
/// metadata at runtime without `dart:mirrors` (unavailable in Flutter) or
/// `build_runner` (not used by this package), so applying `@ResponsiveView`
/// alone does not change behavior — it documents intent for readers, IDE
/// search, and inventory tooling.
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
