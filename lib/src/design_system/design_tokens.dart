import 'package:flutter/widgets.dart';

/// A spacing scale in logical pixels. Defaults follow an 8pt-ish Material
/// rhythm (`4 / 8 / 16 / 24 / 32 / 48`).
@immutable
class SpacingScale {
  /// Extra-small gap.
  final double xs;

  /// Small gap.
  final double sm;

  /// Medium gap (the most common default).
  final double md;

  /// Large gap.
  final double lg;

  /// Extra-large gap.
  final double xl;

  /// Double extra-large gap.
  final double xxl;

  /// Creates a spacing scale. Override any step; the rest keep their defaults.
  const SpacingScale({
    this.xs = 4,
    this.sm = 8,
    this.md = 16,
    this.lg = 24,
    this.xl = 32,
    this.xxl = 48,
  });

  @override
  bool operator ==(Object other) =>
      other is SpacingScale &&
      other.xs == xs &&
      other.sm == sm &&
      other.md == md &&
      other.lg == lg &&
      other.xl == xl &&
      other.xxl == xxl;

  @override
  int get hashCode => Object.hash(xs, sm, md, lg, xl, xxl);
}

/// A corner-radius scale in logical pixels. Defaults: `4 / 8 / 16 / 999`
/// (`pill` is large enough to fully round typical control heights).
@immutable
class RadiusScale {
  /// Small radius.
  final double sm;

  /// Medium radius.
  final double md;

  /// Large radius.
  final double lg;

  /// Fully rounded ("pill") radius.
  final double pill;

  /// Creates a radius scale.
  const RadiusScale({
    this.sm = 4,
    this.md = 8,
    this.lg = 16,
    this.pill = 999,
  });

  @override
  bool operator ==(Object other) =>
      other is RadiusScale &&
      other.sm == sm &&
      other.md == md &&
      other.lg == lg &&
      other.pill == pill;

  @override
  int get hashCode => Object.hash(sm, md, lg, pill);
}

/// Design-system tokens that compose with the styling chains.
///
/// Pairs the theme-driven text tokens (`'Hi'.bodyLarge(context)`) with a
/// [space] and [radius] scale so spacing and corner radius come from one
/// source instead of magic numbers:
///
/// ```dart
/// final t = DesignTokensScope.of(context);
/// Text('Card').box(padding: EdgeInsets.all(t.space.md), radius: t.radius.lg);
/// ```
@immutable
class DesignTokens {
  /// The spacing scale.
  final SpacingScale space;

  /// The corner-radius scale.
  final RadiusScale radius;

  /// Creates a token set. Defaults are Material-aligned.
  const DesignTokens({
    this.space = const SpacingScale(),
    this.radius = const RadiusScale(),
  });

  /// The default tokens, returned by [DesignTokensScope.of] when no scope is
  /// present so consumer code never crashes.
  static const DesignTokens fallback = DesignTokens();

  @override
  bool operator ==(Object other) =>
      other is DesignTokens && other.space == space && other.radius == radius;

  @override
  int get hashCode => Object.hash(space, radius);
}

/// Publishes [DesignTokens] to a subtree. Place it once near the app root:
///
/// ```dart
/// MaterialApp(
///   builder: (context, child) => DesignTokensScope(
///     tokens: const DesignTokens(),
///     child: ResponsiveScope(child: child!),
///   ),
/// );
/// ```
///
/// If no scope is present, [of] falls back to [DesignTokens.fallback], mirroring
/// the resilient lookup used by `ResponsiveScope.of`.
class DesignTokensScope extends InheritedWidget {
  /// The tokens published to the subtree.
  final DesignTokens tokens;

  /// Creates a tokens scope.
  const DesignTokensScope({
    super.key,
    required this.tokens,
    required super.child,
  });

  /// Returns the nearest [DesignTokens], or [DesignTokens.fallback] if none.
  static DesignTokens of(BuildContext context) {
    final scope =
        context.dependOnInheritedWidgetOfExactType<DesignTokensScope>();
    return scope?.tokens ?? DesignTokens.fallback;
  }

  /// Like [of] but returns `null` when no scope is present.
  static DesignTokens? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<DesignTokensScope>()?.tokens;

  @override
  bool updateShouldNotify(DesignTokensScope oldWidget) =>
      tokens != oldWidget.tokens;
}
