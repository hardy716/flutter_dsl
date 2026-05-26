import 'package:flutter/widgets.dart';

/// A reusable spacing widget that provides horizontal and/or vertical gaps.
///
/// Use this when you want to insert fixed space between widgets declaratively.
///
/// ```dart
/// Spacing(w: 12); // horizontal gap only
/// Spacing(h: 8);  // vertical gap only
/// Spacing.square(16); // square spacing
/// ```
class Spacing extends StatelessWidget {
  /// Horizontal spacing
  final double w;

  /// Vertical spacing
  final double h;

  /// Creates a [Spacing] widget with horizontal (`w`) and vertical (`h`) size.
  const Spacing({
    super.key,
    this.w = 0,
    this.h = 0,
  });

  /// Creates a square [Spacing] with equal width and height.
  factory Spacing.square(double size) => Spacing(w: size, h: size);

  /// Creates a horizontal-only [Spacing].
  factory Spacing.horizontal(double width) => Spacing(w: width);

  /// Creates a vertical-only [Spacing].
  factory Spacing.vertical(double height) => Spacing(h: height);

  /// Creates a zero-size [Spacing].
  factory Spacing.none() => const Spacing(w: 0, h: 0);

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: w, height: h);
  }
}
