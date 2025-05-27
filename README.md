# flutter_dsl

> A declarative UI helper extension package for Flutter, making your widget tree more expressive and readable.

[![pub package](https://img.shields.io/pub/v/flutter_dsl.svg)](https://pub.dev/packages/flutter_dsl)

---

## ✨ Features

- ✅ Widget extension methods for spacing, alignment, padding, gestures, etc.
- ✅ String extension for quick `Text()` widget creation with styles
- ✅ Conditional rendering using `.visible()` and `.ifTrue()`
- ✅ Declarative spacing helper: `Spacing(h: 12)`, `Spacing.square(24)`
- ✅ Designed to be expressive, chainable, and Flutter-conventional

---

## 📦 Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_dsl: ^0.1.0
```

Then import:
```dart
import 'package:flutter_dsl/flutter_dsl.dart';
```

🚀 Quick Start

🔹 Widget Extensions
```dart
Text('Login')
  .paddingAll(16)
  .rounded(12)
  .backgroundColor(Colors.blue)
  .center()
  .onTap(() => print('Tapped'));
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
'Error occurred'.text().visible(hasError);

'Edit'.text().ifTrue(isEditable, orElse: () => Icon(Icons.lock));
```

🔹 Spacing DSL
```dart
Spacing(w: 12)         // Horizontal spacing
Spacing(h: 16)         // Vertical spacing
Spacing.square(24)     // Square spacer
Spacing.none()         // Empty SizedBox
```

🧪 Example

See [example/lib/main.dart](https://github.com/hardy716/flutter_dsl/tree/example/lib/main) for a full working demo.