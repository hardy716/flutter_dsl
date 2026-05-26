import 'package:flutter/material.dart';

/// Theme-aware `Text` constructors on [String], pulling styles from the
/// nearest [Theme]'s `textTheme`. Pair with the chainable per-property
/// overrides in `text_styling_extensions.dart` for compact overrides.
///
/// ```dart
/// 'Heading'.titleLarge(context).fontSize(28).textColor(Colors.primary);
/// ```
extension StringTextExtensions on String {
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
