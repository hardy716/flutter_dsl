[![pub package](https://img.shields.io/pub/v/flutter_dsl.svg)](https://pub.dev/packages/flutter_dsl)

# flutter_dsl

- Annotation + extension based **responsive layout** and **design-system-friendly DX** toolkit for Flutter. No `build_runner` required.

`flutter_dsl` lets you write crossplatform, responsive Flutter UI in a single chain — without deeply nested `MediaQuery` / `LayoutBuilder` trees and without code generation. Mark widgets with declarative annotations, layer per-property styling on top of design-system tokens, and branch by screen size with one line.

---

## 🤔 Why flutter_dsl?

An **internal DSL for Flutter** that optimizes for everyday developer experience: responsive layout, design tokens, and styling chains in **one cohesive, codegen-free package** aligned to **Material 3 windowing**.

- **One toolkit, not five.** Responsive branching, a Material 3 `ScreenSize` enum, design tokens (spacing/radius + theme text), and chainable styling — all from a single import, designed to work together.
- **No `build_runner`, no `dart:mirrors`.** Everything runs on const annotations and a runtime `InheritedWidget`. Nothing to generate, no pipeline to maintain.
- **Material 3 windowing, first-class.** `ScreenSize { compact, medium, expanded, large, extraLarge }` is an exhaustive enum — the compiler won't let you forget a bucket.
- **Single source of truth.** Configure breakpoints and design tokens once at the app root; every widget below reads them.
- **Shallow trees by default.** `.box(...)` collapses several decorations into one node, and `Responsive.value(...)` adds zero wrappers on hot paths.

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

## ✨ What's new in v1.1

- **`.box(...)`** — apply padding + color/gradient + border + corner radius + shadow in a **single** `Container`, instead of chaining a wrapper per property.
- **Design tokens**: `DesignTokensScope` + `DesignTokens` with a `SpacingScale` and `RadiusScale`, composing with the theme text tokens and the styling chains.
- **`DesignSystemCatalog`** — an opt-in, codegen-free runtime registry that pairs with `@DesignSystemComponent` to build in-app component galleries.
- **Fixed**: `ResponsiveStatelessWidget` / `ResponsiveStatefulWidget` no longer override an ambient `ResponsiveScope`; they resolve from the app-level scope (single source of truth). The per-widget `breakpoints` parameter is **deprecated** (removed in 2.0) — existing code keeps working with a deprecation hint.

---

## ✨ What's new in v1.0

v1.0 is a **major pivot** from the 0.1.x line. The previous "declarative UI helpers" overlap with what Flutter now ships natively, so v1.0 focuses on the layer above: responsive layout and design-system DX.

- **Responsive primitives**: `ResponsiveScope`, `ResponsiveBuilder`, `Responsive.value(...)`, `.onMobile/.onTablet/.onDesktop/.hideOn*/.responsive` chainable transforms.
- **Marker annotations**: `@ResponsiveView`, `@DesignSystemComponent`, `@BreakpointOverride` — documentation markers that pair with a base class (`ResponsiveStatelessWidget`) for responsive resolution; breakpoints are configured once on `ResponsiveScope`.
- **Material 3 windowing**: `ScreenSize { compact, medium, expanded, large, extraLarge }` plus convenience `isMobile / isTablet / isDesktop`.
- **Compact styling chains**: `.fontSize/.fontWeight/.textColor/.italic/.underline` on `Text`, `.width/.height/.square/.constrained/.aspectRatio` on `Widget`.
- **Functional conditionals**: `.onTrue/.onFalse/.when` for transforms (separate from `.visible` for visibility), plus `WhenWidget<T>` for value-dispatched widgets.
- **No `build_runner`, no `dart:mirrors`** — everything runs through const annotations + a runtime `InheritedWidget`.

0.1.x APIs that conflict with the v1.0 direction are **deprecated** (still work, marked with `@Deprecated`) and will be removed in v2.0. See the migration table below.

---

## 📦 Installation

```yaml
dependencies:
  flutter_dsl: ^1.1.0
```

```dart
import 'package:flutter_dsl/flutter_dsl.dart';
```

---

## 🚀 Quick Start

Wrap your app once in a `ResponsiveScope` (typically via `MaterialApp.builder`). This is the **single source of truth** for breakpoints — set them here, once:

```dart
MaterialApp(
  // Omit `breakpoints` to use the Material 3 defaults [600, 840, 1200, 1600].
  builder: (context, child) =>
      ResponsiveScope(breakpoints: const [600, 840, 1200, 1600], child: child!),
  home: const DashboardPage(),
);
```

Then write responsive widgets with the base class. Mark them with `@ResponsiveView()` for readability/tooling — the marker has no runtime effect on its own:

```dart
@ResponsiveView()
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
| `ResponsiveStatelessWidget` / `ResponsiveStatefulWidget` | Base classes; implement `buildResponsive(context, size)`. They resolve the `ScreenSize` from the ambient `ResponsiveScope` (the app-level single source of truth). |
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
@ResponsiveView()
@DesignSystemComponent(name: 'PrimaryButton', category: 'actions')
@BreakpointOverride([200, 500, 900, 1400])
```

> **How the markers work.** `@ResponsiveView`, `@DesignSystemComponent`, and `@BreakpointOverride` document intent — for readers, IDE search, and inventory tooling — and pair with a runtime counterpart: `@ResponsiveView()` with `extends ResponsiveStatelessWidget` to resolve a `ScreenSize`, and `@DesignSystemComponent` with `DesignSystemCatalog.register(...)` to enumerate components at runtime. There's no `build_runner` and no `dart:mirrors` by design, so configuration stays explicit — set breakpoints **once** on the app-level `ResponsiveScope` (one source of truth).
>
> The `breakpoints` parameter on `@ResponsiveView(...)` / `super(breakpoints: ...)` is **deprecated** (it duplicates the scope config and is removed in 2.0).

### Styling chains

```dart
'Heading'.titleLarge(context)        // design-system token
  .fontSize(28).fontWeight(FontWeight.w700)
  .textColor(Theme.of(context).colorScheme.primary);

myWidget.width(200).height(120).constrained(maxWidth: 400);
```

Each styling wrapper adds one widget node. When you need several decorations at once, prefer **`.box(...)`** — it collapses padding, background, border, corner radius, and shadow into a single `Container`:

```dart
// 3 wrapper nodes (Padding → ColoredBox → ClipRRect):
content.paddingAll(12).backgroundColor(surface).rounded(8);

// 1 node, same result:
content.box(padding: const EdgeInsets.all(12), color: surface, radius: 8);
```

> Caveat: `.width(...)` / `.height(...)` are shadowed by `SizedBox` and `Image` because those types expose `width`/`height` as instance fields. Wrap them once (e.g. in `Padding`, `Center`) before chaining.

### Design tokens

Pair the theme-driven text tokens with a `space` / `radius` scale so spacing and corner radius come from one source instead of magic numbers. Publish a `DesignTokensScope` once near the app root (it falls back to Material-aligned defaults when absent):

```dart
MaterialApp(
  builder: (context, child) => DesignTokensScope(
    tokens: const DesignTokens(),                 // or customize the scales
    child: ResponsiveScope(child: child!),
  ),
);

// Anywhere below:
final t = DesignTokensScope.of(context);
'Card'.bodyLarge(context).box(
  padding: EdgeInsets.all(t.space.md),            // 16
  color: Theme.of(context).colorScheme.surface,
  radius: t.radius.lg,                            // 16
);
```

To turn `@DesignSystemComponent` into an in-app component gallery, register matching entries (no codegen):

```dart
DesignSystemCatalog.register(
  name: 'PrimaryButton', category: 'actions',
  builder: (_) => const PrimaryButton(),
);
for (final e in DesignSystemCatalog.entries) GalleryTile(entry: e);
```

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

- **Annotations document intent; runtime behavior comes from their counterparts** (see above) — pair `@ResponsiveView` with `ResponsiveStatelessWidget`, and `@DesignSystemComponent` with `DesignSystemCatalog`. Breakpoints live on the app-level `ResponsiveScope` (one source of truth). No `build_runner` / `dart:mirrors`.
- **Each styling/transform wrapper adds one widget node.** A long chain trades deep nesting for deep chaining, which is harder to read in the widget inspector and to break on. Keep chains short; for multiple decorations use **`.box(...)`** (one `Container`); for hot paths use the `Responsive.value` / `Responsive.when` static helpers — they take a `BuildContext` and add no nodes. Text styling (`.fontSize`, `.textColor`, …) and conditionals (`.onTrue`, `.when`, …) do **not** add nodes — they merge/return in place.
- **`Text.rich` is not supported** by the text styling chains (`.fontSize`, `.textColor`, …). Construct a `TextSpan` with the style you want instead.
- **0.1.x → 1.0.0** is a major version bump that signals the direction pivot. If you depend on `^0.1.x`, update the constraint and read the migration table.

---

## 🤝 Contributing

Issues and PRs are welcome. Please open an issue first for larger changes.

## 📄 License

MIT License © 2025-2026 HARDY
