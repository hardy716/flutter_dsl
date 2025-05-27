import 'package:flutter/material.dart';

extension StringTextExtensions on String {
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

  Text withStyle(TextStyle style) => Text(this, style: style);

  Text headlineLarge(BuildContext context) => Text(
    this,
    style: Theme.of(context).textTheme.headlineLarge,
  );

  Text headlineMedium(BuildContext context) => Text(
    this,
    style: Theme.of(context).textTheme.headlineMedium,
  );

  Text headlineSmall(BuildContext context) => Text(
    this,
    style: Theme.of(context).textTheme.headlineSmall,
  );

  Text titleLarge(BuildContext context) => Text(
    this,
    style: Theme.of(context).textTheme.titleLarge,
  );

  Text titleMedium(BuildContext context) => Text(
    this,
    style: Theme.of(context).textTheme.titleMedium,
  );

  Text titleSmall(BuildContext context) => Text(
    this,
    style: Theme.of(context).textTheme.titleSmall,
  );

  Text bodyLarge(BuildContext context) => Text(
    this,
    style: Theme.of(context).textTheme.bodyLarge,
  );

  Text bodyMedium(BuildContext context) => Text(
    this,
    style: Theme.of(context).textTheme.bodyMedium,
  );

  Text bodySmall(BuildContext context) => Text(
    this,
    style: Theme.of(context).textTheme.bodySmall,
  );

  Text labelLarge(BuildContext context) => Text(
    this,
    style: Theme.of(context).textTheme.labelLarge,
  );

  Text labelMedium(BuildContext context) => Text(
    this,
    style: Theme.of(context).textTheme.labelMedium,
  );

  Text labelSmall(BuildContext context) => Text(
    this,
    style: Theme.of(context).textTheme.labelSmall,
  );
}
