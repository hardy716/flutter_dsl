[![pub package](https://img.shields.io/pub/v/flutter_dsl.svg)](https://pub.dev/packages/flutter_dsl)

# flutter_dsl

A declarative UI extension toolkit for Flutter, making your widget tree more expressive, readable, and concise.

---

## ✨ Features

- 🔹 Fluent widget extension methods: `.paddingAll()`, `.rounded()`, `.onTap()`, etc.
- 🔹 String-based `Text()` creation: `'Hello'.text(...)`
- 🔹 Theme-aware text styles: `'Title'.titleMedium(context)`
- 🔹 Conditional rendering: `.visible()`, `.ifTrue()`, `.ifFalse()`
- 🔹 Declarative spacing: `Spacing.square(16)`, `.gapBottom(12)`
- 🔹 Designed to be **chainable**, **intuitive**, and **Flutter-conventional**

## 📦 Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_dsl: ^0.1.2
```

Then import it in your Dart files:
```dart
import 'package:flutter_dsl/flutter_dsl.dart';
```

## 🚀 Quick Usage

🔹 Widget DSL
```dart
Text('Login')
  .paddingAll(16)
  .rounded(12)
  .backgroundColor(Colors.blue)
  .center()
  .onTap(() => print('Tapped'));
```

🔹 Iterable Widget DSL
```dart
[
  Icon(Icons.star),
  'Favorite'.text(),
].row(spacing: 8);

[
  'Welcome'.headlineMedium(context),
  'Please log in'.text(),
].column(crossAxisAlignment: CrossAxisAlignment.start, spacing: 16);

[
  'A'.text().backgroundColor(Colors.red),
  'B'.text().backgroundColor(Colors.green).expanded(),
  'C'.text().backgroundColor(Colors.blue).flex(2),
].row();
```

🔹 String → Text DSL
```dart
'Welcome'
  .text(fontSize: 18, fontWeight: FontWeight.bold);

'Title'.titleMedium(context);
'Body'.bodyMedium(context);
'Caption'.labelSmall(context);
```

🔹 Conditional Rendering
```dart
'Error occurred'
  .text()
  .visible(hasError);

'Edit'
  .text()
  .ifTrue(isEditable, orElse: () => Icon(Icons.lock));
```

🔹 Spacing DSL
```dart
Spacing(w: 12);             // Horizontal spacing
Spacing(h: 16);             // Vertical spacing
Spacing.square(24);         // Equal width & height
Spacing.none();             // Empty SizedBox
```

## 🧪 Example

Check out the full working demo in:
📄 [example/lib/main.dart](https://github.com/hardy716/flutter_dsl/blob/master/example/lib/main.dart)

## 📌 Why flutter_dsl?

Flutter UI can be expressive, but often verbose.
This package aims to:
Reduce nesting and boilerplate
Make UI code more readable
Provide reusable and declarative patterns
Stay consistent with Flutter's philosophy

## 🤝 Contributing

We welcome PRs and issues!
Please open an issue or fork and create a PR.

## 📄 License

MIT License
© 2025 HARDY