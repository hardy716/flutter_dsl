[![pub package](https://img.shields.io/pub/v/flutter_dsl.svg)](https://pub.dev/packages/flutter_dsl)

# flutter_dsl

- Annotation + extension based **responsive layout** and **design-system-friendly DX** toolkit for Flutter. No `build_runner` required.

`flutter_dsl` lets you write crossplatform, responsive Flutter UI in a single chain — without deeply nested `MediaQuery` / `LayoutBuilder` trees and without code generation. Mark widgets with declarative annotations, layer per-property styling on top of design-system tokens, and branch by screen size with one line.

---

## 🎬 Demo

![flutter_dsl responsive layout demo](https://raw.githubusercontent.com/hardy716/flutter_dsl/master/doc/demo.gif)

> As the window narrows, the same single chain reflows across `compact → medium → expanded → large` — layout, padding, and styling all adapt automatically. Explore every Core API live in [`example/lib/main.dart`](example/lib/main.dart).

The other showcase tabs at a glance:

| Styling | Text |
| :---: | :---: |
| ![Styling tab](https://raw.githubusercontent.com/hardy716/flutter_dsl/master/doc/tab_styling.png) | ![Text tab](https://raw.githubusercontent.com/hardy716/flutter_dsl/master/doc/tab_text.png) |
| **Conditional** | **Layout** |
| ![Conditional tab](https://raw.githubusercontent.com/hardy716/flutter_dsl/master/doc/tab_conditional.png) | ![Layout tab](https://raw.githubusercontent.com/hardy716/flutter_dsl/master/doc/tab_layout.png) |

---

## ✨ What's new in v1.0

v1.0 is a **major pivot** from the 0.1.x line. The previous "declarative UI helpers" overlap with what Flutter now ships natively, so v1.0 focuses on the layer above: responsive layout and design-system DX.

- **Responsive primitives**: `ResponsiveScope`, `ResponsiveBuilder`, `Responsive.value(...)`, `.onMobile/.onTablet/.onDesktop/.hideOn*/.responsive` chainable transforms.
- **Activated annotations**: `@ResponsiveView`, `@DesignSystemComponent`, `@BreakpointOverride` — markers that pair with a base class (`ResponsiveStatelessWidget`) so the breakpoints you declare actually take effect.
- **Material 3 windowing**: `ScreenSize { compact, medium, expanded, large, extraLarge }` plus convenience `isMobile / isTablet / isDesktop`.
- **Compact styling chains**: `.fontSize/.fontWeight/.textColor/.italic/.underline` on `Text`, `.width/.height/.square/.constrained/.aspectRatio` on `Widget`.
- **Functional conditionals**: `.onTrue/.onFalse/.when` for transforms (separate from `.visible` for visibility), plus `WhenWidget<T>` for value-dispatched widgets.
- **No `build_runner`, no `dart:mirrors`** — everything runs through const annotations + a runtime `InheritedWidget`.

0.1.x APIs that conflict with the v1.0 direction are **deprecated** (still work, marked with `@Deprecated`) and will be removed in v2.0. See the migration table below.

---

## 📦 Installation

```yaml
dependencies:
  flutter_dsl: ^1.0.0
```

```dart
import 'package:flutter_dsl/flutter_dsl.dart';
```

---

## 🚀 Quick Start

Wrap your app once in a `ResponsiveScope` (typically via `MaterialApp.builder`):

```dart
MaterialApp(
  builder: (context, child) => ResponsiveScope(child: child!),
  home: const DashboardPage(),
);
```

Then write responsive widgets with the base class:

```dart
@ResponsiveView(breakpoints: [600, 840, 1200, 1600])
class DashboardPage extends ResponsiveStatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget buildResponsive(BuildContext context, ScreenSize size) {
    return Scaffold(
      appBar: AppBar(title: 'Dashboard — ${size.name}'.titleLarge(context)),
      body: ResponsiveBuilder(
        mobile:  (c) => const MobileLayout(),
        tablet:  (c) => const TabletLayout(),
        desktop: (c) => const DesktopLayout(),
      ),
    );
  }
}
```

Or chain transforms inline:

```dart
'Hide on mobile, scale on desktop'
  .bodyMedium(context)
  .paddingAll(16)
  .backgroundColor(Theme.of(context).colorScheme.surfaceContainerHigh)
  .rounded(12)
  .onDesktop((w) => w.paddingAll(32))
  .hideOnMobile();
```

Or pick raw values with zero tree depth:

```dart
Padding(
  padding: EdgeInsets.all(
    Responsive.value(context, mobile: 16.0, tablet: 24.0, desktop: 40.0),
  ),
  child: ...,
);
```

---

## 🧱 Core APIs

### Responsive

| API | Purpose |
|---|---|
| `ResponsiveScope({breakpoints, child})` | Publishes a `ScreenSize` to the subtree via `InheritedWidget`. Default breakpoints are Material 3 `[600, 840, 1200, 1600]`. |
| `ResponsiveScope.of(context)` | Reads the resolved `ScreenSize`. Falls back to `MediaQuery` + Material 3 breakpoints when no scope is present, so it never crashes. |
| `ResponsiveScope.maybeOf(context)` | Like `of` but returns `null` when no scope is present. |
| `ResponsiveScope.dataOf(context)` | Returns `ResponsiveData(size, width, breakpoints)`. |
| `ResponsiveStatelessWidget` / `ResponsiveStatefulWidget` | Base classes; implement `buildResponsive(context, size)` and the scope wrap happens automatically. |
| `ResponsiveBuilder({mobile, tablet?, desktop?})` | Picks a builder per screen size, with `desktop → tablet → mobile` fallback. |
| `Responsive.value<T>(context, {mobile, tablet?, desktop?})` | Picks a value (any `T`) per size. Zero wrapper widgets. |
| `Responsive.when(context, {mobile, tablet?, desktop?})` | Picks a widget per size. Zero wrapper widgets. |
| `Responsive.isMobile/isTablet/isDesktop(context)` | Convenience flags. |

Chainable transforms (extensions on `Widget`):

```dart
widget.onMobile((w) => w.paddingAll(8))
widget.onDesktop((w) => w.constrained(maxWidth: 1080))
widget.hideOnDesktop()
widget.responsive(mobile: ..., tablet: ..., desktop: ...)
```

### Annotations (markers)

```dart
@ResponsiveView(breakpoints: [400, 800, 1200, 1600])
@DesignSystemComponent(name: 'PrimaryButton', category: 'actions')
@BreakpointOverride([200, 500, 900, 1400])
```

> **Annotations are markers, not magic.** Dart cannot read annotation metadata at runtime without `dart:mirrors` (unavailable in Flutter) or `build_runner` (not used here). For an annotation's `breakpoints` to actually take effect, the annotated class should also `extends ResponsiveStatelessWidget` and pass the same list to `super(breakpoints: ...)`. The base class then wraps the subtree in `ResponsiveScope`. Keeping the two in sync is your responsibility.

### Styling chains

```dart
'Heading'.titleLarge(context)        // design-system token
  .fontSize(28).fontWeight(FontWeight.w700)
  .textColor(Theme.of(context).colorScheme.primary);

myWidget.width(200).height(120).constrained(maxWidth: 400);
```

> Caveat: `.width(...)` / `.height(...)` are shadowed by `SizedBox` and `Image` because those types expose `width`/`height` as instance fields. Wrap them once (e.g. in `Padding`, `Center`) before chaining.

### Functional conditionals (v1.0)

```dart
card.onTrue(isHighlighted, (w) => w.backgroundColor(Colors.yellow));
card.onFalse(isCompact,    (w) => w.paddingAll(24));

card.when({
  isError:   (w) => w.backgroundColor(Colors.red),
  isWarning: (w) => w.backgroundColor(Colors.orange),
});

WhenWidget<Status>(
  value: status,
  cases: {
    Status.loading: () => const CircularProgressIndicator(),
    Status.error:   () => const Icon(Icons.error),
  },
  orElse: () => const SizedBox.shrink(),
);
```

### Kept from 0.x.x

`paddingAll/paddingSymmetric/paddingOnly`, `center/align/expanded/flex`, `rounded`, `backgroundColor` (now `ColoredBox` internally), `onTap`, theme-aware `Text` tokens (`headlineLarge` … `labelSmall`), `Spacing` widget, `Iterable<Widget>.row/column`, and `.visible(cond)` are all kept.

---

## 🔁 Migration Guide

| 0.x.x | 1.0.0 |
|----------------------------------------------|---|
| `widget.marginAll(8)`                        | `widget.paddingAll(8)` or a `Spacing` in the parent |
| `'Hi'.text(fontSize: 18, color: Colors.red)` | `'Hi'.bodyLarge(context).fontSize(18).textColor(Colors.red)` |
| `'Hi'.withStyle(myStyle)`                    | `Text('Hi', style: myStyle)` |
| `iconA.gapRight(8)`                          | `[iconA, ...].row(spacing: 8)` |
| `widget.ifTrue(cond)` (visibility)           | `widget.visible(cond)` |
| `widget.ifTrue(cond, orElse: () => other)`   | `cond ? widget : other` or `WhenWidget<bool>(value: cond, cases: {true: () => widget, false: () => other})` |
| `widget.ifFalse(cond)`                       | `widget.visible(!cond)` |
| (transform on condition)                     | `widget.onTrue(cond, (w) => w.backgroundColor(Colors.yellow))` |

Deprecated 0.1.x APIs are still functional and marked with `@Deprecated`. They will be removed in **v2.0**.

---

## 🧪 Example

A full v1.0 demo lives in [`example/lib/main.dart`](https://github.com/hardy716/flutter_dsl/blob/master/example/lib/main.dart). Run it:

```bash
cd example
flutter run
```

Try resizing your window to see the responsive transforms kick in.

---

## ⚠️ Trade-offs

- **Annotations are markers, not magic** (see above). For runtime effect, pair them with `ResponsiveStatelessWidget`.
- **Chainable responsive transforms add one wrapper widget each.** For hot paths where tree depth matters, use the `Responsive.value` / `Responsive.when` static helpers — they take a `BuildContext` and add no nodes.
- **`Text.rich` is not supported** by the text styling chains (`.fontSize`, `.textColor`, …). Construct a `TextSpan` with the style you want instead.
- **0.1.x → 1.0.0** is a major version bump that signals the direction pivot. If you depend on `^0.1.x`, update the constraint and read the migration table.

---

## 🤝 Contributing

Issues and PRs are welcome. Please open an issue first for larger changes.

## 📄 License

MIT License © 2025-2026 HARDY
