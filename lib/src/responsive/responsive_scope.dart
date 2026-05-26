import 'package:flutter/widgets.dart';

import 'breakpoints.dart';
import 'screen_size.dart';

/// Snapshot of the responsive environment, exposed via [ResponsiveScope.dataOf].
class ResponsiveData {
  /// The resolved size bucket.
  final ScreenSize size;

  /// The width that produced [size], in logical pixels.
  final double width;

  /// The breakpoints in effect.
  final List<int> breakpoints;

  /// Creates a snapshot. Usually obtained from [ResponsiveScope.dataOf].
  const ResponsiveData(this.size, this.width, this.breakpoints);
}

/// Wraps a subtree and publishes a [ScreenSize] bucket computed from the
/// nearest [MediaQuery] and the supplied [breakpoints].
///
/// Place this above your app — typically in `MaterialApp.builder`:
///
/// ```dart
/// MaterialApp(
///   builder: (context, child) => ResponsiveScope(child: child!),
///   home: const HomePage(),
/// );
/// ```
///
/// If no [ResponsiveScope] is present, [of] still works using
/// [Breakpoints.material3] as a fallback, so consumer code never crashes.
class ResponsiveScope extends StatelessWidget {
  /// Ascending list of four width thresholds. Defaults to the Material 3
  /// breakpoints (`[600, 840, 1200, 1600]`).
  final List<int> breakpoints;

  /// The subtree that will read the scope.
  final Widget child;

  /// Creates a scope. [breakpoints] must contain exactly four ascending values.
  const ResponsiveScope({
    super.key,
    this.breakpoints = Breakpoints.material3,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return _ResponsiveScopeData(
      size: Breakpoints.resolve(width, breakpoints),
      width: width,
      breakpoints: breakpoints,
      child: child,
    );
  }

  /// Returns the current [ScreenSize]. Falls back to [MediaQuery] + Material 3
  /// breakpoints when no [ResponsiveScope] exists in the tree.
  static ScreenSize of(BuildContext context) {
    final data =
        context.dependOnInheritedWidgetOfExactType<_ResponsiveScopeData>();
    if (data != null) return data.size;
    return Breakpoints.resolve(
      MediaQuery.sizeOf(context).width,
      Breakpoints.material3,
    );
  }

  /// Like [of] but returns `null` when no [ResponsiveScope] is present.
  static ScreenSize? maybeOf(BuildContext context) {
    final data =
        context.dependOnInheritedWidgetOfExactType<_ResponsiveScopeData>();
    return data?.size;
  }

  /// Returns the full [ResponsiveData] (size + width + breakpoints).
  /// Uses [MediaQuery] + Material 3 fallback when no scope is present.
  static ResponsiveData dataOf(BuildContext context) {
    final data =
        context.dependOnInheritedWidgetOfExactType<_ResponsiveScopeData>();
    if (data != null) {
      return ResponsiveData(data.size, data.width, data.breakpoints);
    }
    final w = MediaQuery.sizeOf(context).width;
    return ResponsiveData(
      Breakpoints.resolve(w, Breakpoints.material3),
      w,
      Breakpoints.material3,
    );
  }
}

class _ResponsiveScopeData extends InheritedWidget {
  final ScreenSize size;
  final double width;
  final List<int> breakpoints;

  const _ResponsiveScopeData({
    required this.size,
    required this.width,
    required this.breakpoints,
    required super.child,
  });

  @override
  bool updateShouldNotify(_ResponsiveScopeData old) =>
      old.size != size || old.width != width;
}
