import 'package:flutter/material.dart';

/// Extension methods for inserting spacing widgets (SizedBox) relative to another widget.
///
/// Allows writing readable and declarative UI like:
/// ```dart
/// Icon(Icons.star).gapRight(8)
/// 'Text'.text().gapBottom(16)
/// ```
extension SpacingExtensions on Widget {
  /// Adds horizontal spacing to the **right** of the widget using a [Row].
  ///
  /// ```dart
  /// Icon(Icons.star).gapRight(8);
  /// ```
  Widget gapRight(double width) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      this,
      SizedBox(width: width),
    ],
  );

  /// Adds horizontal spacing to the **left** of the widget using a [Row].
  ///
  /// ```dart
  /// Icon(Icons.star).gapLeft(8);
  /// ```
  Widget gapLeft(double width) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      SizedBox(width: width),
      this,
    ],
  );

  /// Adds vertical spacing to the **bottom** of the widget using a [Column].
  ///
  /// ```dart
  /// Text('Hello').gapBottom(16);
  /// ```
  Widget gapBottom(double height) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      this,
      SizedBox(height: height),
    ],
  );

  /// Adds vertical spacing to the **top** of the widget using a [Column].
  ///
  /// ```dart
  /// Text('Hello').gapTop(16);
  /// ```
  Widget gapTop(double height) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      SizedBox(height: height),
      this,
    ],
  );
}

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