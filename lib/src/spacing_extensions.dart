import 'package:flutter/material.dart';

extension SpacingExtensions on Widget {
  Widget gapRight(double width) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      this,
      SizedBox(width: width),
    ],
  );

  Widget gapLeft(double width) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      SizedBox(width: width),
      this,
    ],
  );

  Widget gapBottom(double height) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      this,
      SizedBox(height: height),
    ],
  );

  Widget gapTop(double height) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      SizedBox(height: height),
      this,
    ],
  );
}

class Spacing extends StatelessWidget {
  final double w;
  final double h;

  const Spacing({
    super.key,
    this.w = 0,
    this.h = 0,
  });

  factory Spacing.square(double size) => Spacing(w: size, h: size);

  factory Spacing.horizontal(double width) => Spacing(w: width);

  factory Spacing.vertical(double height) => Spacing(h: height);

  factory Spacing.none() => const Spacing(w: 0, h: 0);

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: w, height: h);
  }
}
