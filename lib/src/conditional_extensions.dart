import 'package:flutter/material.dart';

extension ConditionalExtensions on Widget {
  Widget visible(bool condition) => condition ? this : const SizedBox.shrink();

  Widget ifTrue(bool condition, {Widget Function()? orElse}) =>
      condition ? this : (orElse?.call() ?? const SizedBox.shrink());

  Widget ifFalse(bool condition, {Widget Function()? orElse}) =>
      !condition ? this : (orElse?.call() ?? const SizedBox.shrink());
}
