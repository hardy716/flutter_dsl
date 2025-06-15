import 'package:flutter/material.dart';

/// Provides convenient methods to convert a [String] into a [Text] widget with optional styling.
///
/// This allows writing expressive and declarative Flutter UI code like:
/// ```dart
/// 'Hello World'.text(fontSize: 18, fontWeight: FontWeight.bold);
/// ```
extension StringTextExtensions on String {
  /// Converts the string into a [Text] widget with optional styling parameters.
  ///
  /// ```dart
  /// 'Hello'.text(fontSize: 16, color: Colors.blue);
  /// ```
  Text text({
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.normal,
    Color color = Colors.black,
    TextAlign textAlign = TextAlign.start,
    int? maxLines,
    TextOverflow? overflow,
  }) {
    return Text(
      this,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }

  /// Converts the string into a [Text] widget using a given [TextStyle].
  ///
  /// ```dart
  /// 'Custom'.withStyle(TextStyle(color: Colors.red));
  /// ```
  Text withStyle(TextStyle style) => Text(this, style: style);

  /// Uses the theme's [headlineLarge] text style.
  Text headlineLarge(BuildContext context) => Text(
        this,
        style: Theme.of(context).textTheme.headlineLarge,
      );

  /// Uses the theme's [headlineMedium] text style.
  Text headlineMedium(BuildContext context) => Text(
        this,
        style: Theme.of(context).textTheme.headlineMedium,
      );

  /// Uses the theme's [headlineSmall] text style.
  Text headlineSmall(BuildContext context) => Text(
        this,
        style: Theme.of(context).textTheme.headlineSmall,
      );

  /// Uses the theme's [titleLarge] text style.
  Text titleLarge(BuildContext context) => Text(
        this,
        style: Theme.of(context).textTheme.titleLarge,
      );

  /// Uses the theme's [titleMedium] text style.
  Text titleMedium(BuildContext context) => Text(
        this,
        style: Theme.of(context).textTheme.titleMedium,
      );

  /// Uses the theme's [titleSmall] text style.
  Text titleSmall(BuildContext context) => Text(
        this,
        style: Theme.of(context).textTheme.titleSmall,
      );

  /// Uses the theme's [bodyLarge] text style.
  Text bodyLarge(BuildContext context) => Text(
        this,
        style: Theme.of(context).textTheme.bodyLarge,
      );

  /// Uses the theme's [bodyMedium] text style.
  Text bodyMedium(BuildContext context) => Text(
        this,
        style: Theme.of(context).textTheme.bodyMedium,
      );

  /// Uses the theme's [bodySmall] text style.
  Text bodySmall(BuildContext context) => Text(
        this,
        style: Theme.of(context).textTheme.bodySmall,
      );

  /// Uses the theme's [labelLarge] text style.
  Text labelLarge(BuildContext context) => Text(
        this,
        style: Theme.of(context).textTheme.labelLarge,
      );

  /// Uses the theme's [labelMedium] text style.
  Text labelMedium(BuildContext context) => Text(
        this,
        style: Theme.of(context).textTheme.labelMedium,
      );

  /// Uses the theme's [labelSmall] text style.
  Text labelSmall(BuildContext context) => Text(
        this,
        style: Theme.of(context).textTheme.labelSmall,
      );
}
