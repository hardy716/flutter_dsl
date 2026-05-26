import 'screen_size.dart';

/// Utilities for resolving a width into a [ScreenSize] bucket.
class Breakpoints {
  Breakpoints._();

  /// Material 3 default breakpoints in logical pixels:
  /// `[600, 840, 1200, 1600]`.
  static const List<int> material3 = [600, 840, 1200, 1600];

  /// Resolves [width] to a [ScreenSize] using four ascending [breakpoints].
  ///
  /// `width < breakpoints[0]` → [ScreenSize.compact]
  /// `width < breakpoints[1]` → [ScreenSize.medium]
  /// `width < breakpoints[2]` → [ScreenSize.expanded]
  /// `width < breakpoints[3]` → [ScreenSize.large]
  /// otherwise → [ScreenSize.extraLarge]
  static ScreenSize resolve(double width, List<int> breakpoints) {
    assert(
      breakpoints.length == 4,
      'breakpoints must contain exactly four ascending thresholds',
    );
    if (width < breakpoints[0]) return ScreenSize.compact;
    if (width < breakpoints[1]) return ScreenSize.medium;
    if (width < breakpoints[2]) return ScreenSize.expanded;
    if (width < breakpoints[3]) return ScreenSize.large;
    return ScreenSize.extraLarge;
  }
}
