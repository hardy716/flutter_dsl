import 'package:meta/meta.dart';

/// Declarative marker to document that a member uses different breakpoints
/// from its enclosing [ResponsiveView]. Marker only — no runtime behavior.
@immutable
@Target({TargetKind.method, TargetKind.field, TargetKind.getter})
class BreakpointOverride {
  /// Breakpoints that apply to this specific member.
  final List<int> breakpoints;

  /// Creates a per-member breakpoint override marker.
  const BreakpointOverride(this.breakpoints);
}
