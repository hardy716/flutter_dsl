import 'package:flutter/material.dart';

/// Chainable per-property styling for [Text]. Each call returns a new [Text]
/// with the additional [TextStyle] property merged onto any existing style.
///
/// Designed to layer overrides on top of a design-system token:
///
/// ```dart
/// 'Title'.titleLarge(context)
///   .fontSize(28)
///   .textColor(Theme.of(context).colorScheme.primary);
/// ```
///
/// Not supported for [Text.rich] — call sites that pass a `textSpan` will trip
/// an assertion in debug builds, because the merge path only copies the
/// `data` field.
extension TextStylingExtensions on Text {
  /// Sets the font size, merging onto any existing style.
  Text fontSize(double value) => _merge(TextStyle(fontSize: value));

  /// Sets the font weight, merging onto any existing style.
  Text fontWeight(FontWeight value) => _merge(TextStyle(fontWeight: value));

  /// Sets the text color, merging onto any existing style.
  Text textColor(Color value) => _merge(TextStyle(color: value));

  /// Sets letter spacing, merging onto any existing style.
  Text letterSpacing(double value) =>
      _merge(TextStyle(letterSpacing: value));

  /// Sets the line height multiplier (`TextStyle.height`).
  Text lineHeight(double value) => _merge(TextStyle(height: value));

  /// Sets `FontStyle.italic` on the merged style.
  Text italic() => _merge(const TextStyle(fontStyle: FontStyle.italic));

  /// Sets `TextDecoration.underline` on the merged style.
  Text underline() =>
      _merge(const TextStyle(decoration: TextDecoration.underline));

  Text _merge(TextStyle delta) {
    assert(
      textSpan == null,
      'TextStylingExtensions does not support Text.rich; '
      'construct a TextSpan with the desired style instead.',
    );
    final base = style ?? const TextStyle();
    return Text(
      data ?? '',
      key: key,
      style: base.merge(delta),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      textDirection: textDirection,
      locale: locale,
      semanticsLabel: semanticsLabel,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
      strutStyle: strutStyle,
      textScaler: textScaler,
      selectionColor: selectionColor,
    );
  }
}
