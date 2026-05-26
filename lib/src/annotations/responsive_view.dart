import 'package:meta/meta.dart';

/// Declarative marker that announces a widget as a responsive layout host.
///
/// This annotation is a **marker, not magic**. Dart cannot read annotation
/// metadata at runtime without `dart:mirrors` (unavailable in Flutter) or
/// `build_runner` (not used by this package), so applying `@ResponsiveView`
/// alone does not change behavior.
///
/// For the [breakpoints] you specify here to actually take effect, the
/// annotated widget should also `extends ResponsiveStatelessWidget` (or
/// `ResponsiveStatefulWidget`) and pass the same list to its `super(...)`
/// constructor. The base class then wraps the subtree in a `ResponsiveScope`.
///
/// ```dart
/// @ResponsiveView(breakpoints: [400, 800, 1200, 1600])
/// class Dashboard extends ResponsiveStatelessWidget {
///   const Dashboard({super.key})
///     : super(breakpoints: const [400, 800, 1200, 1600]);
///
///   @override
///   Widget buildResponsive(BuildContext context, ScreenSize size) { ... }
/// }
/// ```
@immutable
@Target({TargetKind.classType})
class ResponsiveView {
  /// Ascending list of four width thresholds in logical pixels. Defaults to
  /// the Material 3 windowing breakpoints (compact / medium / expanded /
  /// large / extraLarge).
  final List<int> breakpoints;

  /// Creates a marker for a responsive view.
  const ResponsiveView({
    this.breakpoints = const [600, 840, 1200, 1600],
  });
}
