import 'package:flutter/material.dart';

/// Deprecated `String → Text` helpers that bypass the design-system tokens.
///
/// **Status**: Deprecated in v1.0, scheduled for removal in v2.0. Prefer theme
/// tokens (`'Hi'.bodyLarge(context)`) combined with chainable per-property
/// overrides (`.fontSize(...).textColor(...)`).
extension DeprecatedStringTextExtensions on String {
  /// Converts the string into a [Text] widget with optional styling parameters.
  ///
  /// ```dart
  /// 'Hello'.text(fontSize: 16, color: Colors.blue);
  /// ```
  @Deprecated(
    'Deprecated in v1.0. Prefer theme tokens with chained styling, e.g. '
    "'Hello'.bodyLarge(context).fontSize(16).textColor(Colors.blue). "
    'Will be removed in v2.0.',
  )
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
  @Deprecated(
    'Deprecated in v1.0. Use `Text(this, style: ...)` directly, or compose '
    'theme tokens with chained styling (e.g. .bodyLarge(context).fontSize(...)). '
    'Will be removed in v2.0.',
  )
  Text withStyle(TextStyle style) => Text(this, style: style);
}
