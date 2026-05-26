import 'package:flutter/widgets.dart';

/// Functional conditional helpers that transform a widget rather than gating
/// visibility. Complementary to [ConditionalExtensions.visible].
///
/// ```dart
/// CustomCard()
///   .paddingAll(12)
///   .onTrue(isHighlighted, (w) => w.backgroundColor(Colors.yellow))
///   .onFalse(isCompact, (w) => w.paddingAll(24));
/// ```
extension FunctionalConditionalExtensions on Widget {
  /// Returns `transform(this)` if [condition] is `true`, else `this`.
  Widget onTrue(bool condition, Widget Function(Widget w) transform) =>
      condition ? transform(this) : this;

  /// Returns `transform(this)` if [condition] is `false`, else `this`.
  Widget onFalse(bool condition, Widget Function(Widget w) transform) =>
      !condition ? transform(this) : this;

  /// Applies the transform attached to the first `true` key in [cases].
  /// Returns `this` when no key is `true`.
  ///
  /// ```dart
  /// card.when({
  ///   isError:   (w) => w.backgroundColor(Colors.red),
  ///   isWarning: (w) => w.backgroundColor(Colors.orange),
  /// });
  /// ```
  Widget when(Map<bool, Widget Function(Widget w)> cases) {
    for (final entry in cases.entries) {
      if (entry.key) return entry.value(this);
    }
    return this;
  }
}

/// Value-based switch widget. Picks the builder whose key matches [value] and
/// falls back to [orElse] (or [SizedBox.shrink]) when no key matches.
///
/// ```dart
/// WhenWidget<Status>(
///   value: status,
///   cases: {
///     Status.loading: () => const CircularProgressIndicator(),
///     Status.error:   () => const Icon(Icons.error),
///     Status.ok:     () => const Icon(Icons.check),
///   },
/// );
/// ```
class WhenWidget<T> extends StatelessWidget {
  /// The value to dispatch on.
  final T value;

  /// Builders keyed by value.
  final Map<T, Widget Function()> cases;

  /// Builder used when no key in [cases] matches [value].
  final Widget Function()? orElse;

  /// Creates a value-dispatched widget.
  const WhenWidget({
    super.key,
    required this.value,
    required this.cases,
    this.orElse,
  });

  @override
  Widget build(BuildContext context) {
    final builder = cases[value] ?? orElse;
    return builder?.call() ?? const SizedBox.shrink();
  }
}
