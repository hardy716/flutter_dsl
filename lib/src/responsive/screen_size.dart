/// Material 3 windowing size class.
///
/// Five buckets are exposed (`compact`, `medium`, `expanded`, `large`,
/// `extraLarge`) so apps that care about the full Material spec can branch
/// on the exact bucket, while three convenience getters
/// ([isMobile] / [isTablet] / [isDesktop]) cover the common case.
enum ScreenSize {
  /// width < first breakpoint (phone in portrait).
  compact,

  /// first ≤ width < second (small tablet).
  medium,

  /// second ≤ width < third (large tablet, foldable).
  expanded,

  /// third ≤ width < fourth (laptop, small desktop).
  large,

  /// width ≥ fourth (large desktop, TV).
  extraLarge;

  /// True for `compact`.
  bool get isMobile => this == ScreenSize.compact;

  /// True for `medium` and `expanded`.
  bool get isTablet => this == ScreenSize.medium || this == ScreenSize.expanded;

  /// True for `large` and `extraLarge`.
  bool get isDesktop =>
      this == ScreenSize.large || this == ScreenSize.extraLarge;
}
