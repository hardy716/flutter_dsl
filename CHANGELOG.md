## [1.1.0]

### Added

- `.box({padding, color, gradient, border, radius / borderRadius, boxShadow, clipBehavior})` — collapses multiple decorations into a **single** `Container`, replacing deep wrapper chains like `.paddingAll().backgroundColor().rounded()` and keeping the widget tree shallow.
- **Design tokens**: `DesignTokens` + `DesignTokensScope` (resilient `of` / `maybeOf` lookup) carrying a `SpacingScale` (`4 / 8 / 16 / 24 / 32 / 48`) and `RadiusScale` (`4 / 8 / 16 / 999`). Composes with the theme text tokens and styling chains so spacing/radius come from one source instead of magic numbers.
- `DesignSystemCatalog` — an opt-in, codegen-free runtime registry (`register` / `entries` / `byCategory`) that pairs with `@DesignSystemComponent` to build in-app component galleries / storybooks.

### Deprecated

- The `breakpoints` parameter on `@ResponsiveView(...)` and on the `ResponsiveStatelessWidget` / `ResponsiveStatefulWidget` constructors. Configure breakpoints **once** on the app-level `ResponsiveScope` (single source of truth). Existing code keeps compiling and running (deprecation warning only); the parameter is removed in 2.0.

### Fixed

- `ResponsiveStatelessWidget` / `ResponsiveStatefulWidget` no longer **override** an ambient `ResponsiveScope` with the Material 3 defaults. When no (deprecated) per-widget `breakpoints` are passed, they now resolve the `ScreenSize` from the nearest app-level `ResponsiveScope` (falling back to `MediaQuery` + Material 3 only when none exists), so app-level custom breakpoints correctly propagate into responsive widgets. Passing per-widget `breakpoints` preserves the previous wrapping behavior.

### Documentation

- New top-level "Why flutter_dsl?" section positioning the package as a cohesive, codegen-free **internal DSL** (responsive + design tokens + styling, aligned to Material 3 windowing), plus a "What's new in v1.1" summary.
- Quick Start and annotation docs moved to the single-source `ResponsiveScope` pattern; added a **Design tokens** section, `.box` usage, and tree-depth/debugging guidance in Trade-offs.
- The example app now showcases `.box`, `DesignTokensScope`, and `DesignSystemCatalog`; the demo GIF and screenshots were refreshed.

## [1.0.0+5]

### Documentation

- Added a **Demo** section to `README.md`: an animated GIF of the example app's responsive reflow (`compact → medium → expanded → large`) plus a 2×2 screenshot grid of the **Styling** / **Text** / **Conditional** / **Layout** tabs. Assets live in `doc/` (excluded from the pub archive via `.pubignore`) and are referenced by raw GitHub URLs so they render on pub.dev.

## [1.0.0+4]

### Fixed

- Example app `Icons.*` glyphs no longer render as `[x]` tofu boxes. Root cause: `example/pubspec.yaml` had no `flutter:` section, so the Material Icons font was never bundled. Added `flutter: { uses-material-design: true }`.

## [1.0.0+3]

### Changed

- Example app rewritten as a 5-tab Core API showcase
  - Tabs: **Responsive** / **Styling** / **Text** / **Conditional** / **Layout**
  - Each demo card pairs a live widget with a copy-paste-friendly code snippet (`SelectableText` in a monospace block)
  - Interactive `Switch` / `SegmentedButton` controls drive the transform-based helpers (`.onTrue` / `.onFalse` / `.when` / `WhenWidget`) so users can see state transitions in real time
  - Live `ScreenSize` chip in the `AppBar` (icon + color per bucket) — proves responsive helpers are tracking the actual width
  - Top-of-tab hint banner explains how to drive the responsive demos (resize the window)
  - Demonstrates every Core API surface from `README.md`'s table: `ResponsiveBuilder`, `Responsive.value/when/isMobile/isTablet/isDesktop`, `.onMobile/.onTablet/.onDesktop`, `.hideOnMobile/Tablet/Desktop`, `.responsive`, `ResponsiveScope.dataOf`, marker annotations, all 12 theme text tokens, styling chains, `WhenWidget<T>`, sizing extensions, `Iterable<Widget>.row/.column`, `.expanded/.flex`, `Spacing`

## [1.0.0+2]

### Added

- Example app platform scaffolding for `android`, `ios`, `linux`, `macos`, `web`, `windows` (via `flutter create --platforms=...`) so the demo builds on every supported platform out of the box
- `.pubignore` at the package root to keep the pub archive lean by excluding `example/`'s native platform directories and template boilerplate (only `example/lib/main.dart` + `example/pubspec.yaml` ship to pub.dev)

### Removed

- `example/test/widget_test.dart` — leftover `flutter create` counter template referencing the non-existent `MyApp`. The example's behavior is exercised by the package's own test suite

### Documentation

- README intro line restyled from blockquote (`>`) to bullet (`-`) for tighter rendering on pub.dev

## [1.0.0+1]

### Documentation

- Updated `LICENSE` copyright year from `2025` to `2025-2026`
- Updated `README.md` footer to match the new license year

## [1.0.0]

This is a **major version bump from 0.1.x**. The package pivots from "declarative
UI helpers" to an annotation + extension toolkit for crossplatform responsive
layouts and design-system-friendly DX. No `build_runner`, no `dart:mirrors`.

### BREAKING CHANGES
None at the source level — 0.1.x APIs that conflict with the new direction are
marked `@Deprecated` and continue to work in v1.x. They will be **removed in v2.0**.

### Added
- `ScreenSize` enum (Material 3: `compact / medium / expanded / large / extraLarge`) with `isMobile / isTablet / isDesktop` getters.
- `Breakpoints.resolve(width, breakpoints)` + `Breakpoints.material3 = [600, 840, 1200, 1600]`.
- `ResponsiveScope` `InheritedWidget` — `of(context)` / `maybeOf` / `dataOf`, with `MediaQuery` fallback when no scope is present.
- `ResponsiveStatelessWidget` / `ResponsiveStatefulWidget` + `ResponsiveState` base classes — auto-wrap the subtree in `ResponsiveScope` and forward `ScreenSize` to `buildResponsive(context, size)`.
- `ResponsiveBuilder({mobile, tablet?, desktop?})` widget with `desktop → tablet → mobile` fallback.
- Widget extensions: `.onMobile / .onTablet / .onDesktop`, `.hideOnMobile / .hideOnTablet / .hideOnDesktop`, `.responsive({mobile, tablet, desktop})`.
- `Responsive.value<T>(context, ...)` / `Responsive.when(context, ...)` / `isMobile/isTablet/isDesktop(context)` — context-aware static helpers that add **no wrapper widgets**.
- Marker annotations: `@ResponsiveView({breakpoints})`, `@DesignSystemComponent({name, category})`, `@BreakpointOverride(breakpoints)`. Markers only; pair with `ResponsiveStatelessWidget` for runtime effect.
- Widget styling extensions: `.size(w,h) / .width / .height / .square / .constrained({min/maxWidth/Height}) / .aspectRatio`.
- Text styling extensions: `.fontSize / .fontWeight / .textColor / .letterSpacing / .lineHeight / .italic / .underline` — merge onto the existing `TextStyle` so design-system tokens compose cleanly with per-property overrides. `Text.rich` is not supported (debug `assert`).
- Functional conditional extensions: `.onTrue / .onFalse / .when` (transforms, distinct from `.visible` which gates visibility).
- `WhenWidget<T>({value, cases, orElse?})` — value-dispatched widget switch.
- Test suite: 55 tests under `test/` covering responsive resolution, scope wiring, transforms, styling merges, conditional behavior, and annotation metadata.
- `example/pubspec.yaml` — previously missing; the example app is now runnable.

### Changed
- `Widget.backgroundColor(...)` internal implementation changed from `Container` to `ColoredBox` (external signature unchanged).
- `analysis_options.yaml`: added `prefer_const_constructors`, `prefer_const_literals_to_create_immutables`, `use_super_parameters`, `require_trailing_commas`.

### Deprecated (will be removed in v2.0)
All deprecated APIs have been gathered under `lib/src/deprecated/` to visually
separate them from the active surface. They remain re-exported from the
package barrel so existing 0.1.x consumer code keeps compiling.

- `Widget.marginAll / marginSymmetric / marginOnly` (`lib/src/deprecated/widget_margin_extensions.dart`) — implicit `Container` wrapping. Use `paddingAll` / `paddingSymmetric` / `paddingOnly` or a `Spacing` widget instead.
- `String.text({fontSize, color, ...})` (`lib/src/deprecated/string_text_extensions.dart`) — bypasses design-system tokens. Use a theme token + `.fontSize/.textColor` chain (e.g. `'Hi'.bodyLarge(context).fontSize(18)`).
- `String.withStyle(TextStyle)` (`lib/src/deprecated/string_text_extensions.dart`) — bypasses design-system tokens. Use `Text(value, style: ...)` directly.
- `Widget.gapLeft / gapRight / gapTop / gapBottom` (entire `SpacingExtensions`, `lib/src/deprecated/spacing_extensions.dart`) — implicit `Row`/`Column` wrapping collides when chained. Use `Iterable<Widget>.row(spacing: ...)` / `.column(spacing: ...)` or a `Spacing` widget on the parent.
- `Widget.ifTrue / ifFalse` (`lib/src/deprecated/conditional_extensions.dart`) — visibility semantics overlap with `.visible(cond)`, transform semantics overlap with the new `.onTrue / .onFalse`.

### Migration
See the migration table in `README.md`.

### Dependencies
- Added `meta: ^1.10.0` (for `@Target` metadata on marker annotations).
- Added dev dependency `flutter_lints: ^4.0.0`.

---

## [0.1.2+2]

### Documentation

- Fixed dartdoc issues related to angle brackets (`<T>`, `<Widget>`)
- Applied `dart format .` to match Dart style guidelines and improve pub.dev score

## [0.1.2+1]

### Features

- `expanded()` and `flex(n)` to `WidgetExtensions`
    - Easily wrap widgets in `Expanded` or `Flexible`
    - Example: `'Content'.text().expanded()` or `.flex(2)`

- `row()` and `column()` to `Iterable<Widget>` via `IterableWidgetExtensions`
    - Convert list of widgets into `Row` or `Column` with DSL-style
    - Example: `[A, B, C].row()` or `.column(...)`

## [0.1.1]

### Documentation

- Added `dartdoc` comments to all public extension methods:
    - `WidgetModifiers`
    - `StringTextExtensions`
    - `SpacingExtensions`
    - `ConditionalExtensions`

- Updated `README.md`:
    - Improved feature descriptions and usage examples
    - Added badge and link to full example
    - Highlighted motivation and future roadmap

## [0.1.0]

### Initial Release

- Introduced fluent DSL-style widget extensions
- Added string → `Text` conversion methods with theme support
- Included spacing and conditional rendering DSL
- Provided example app demonstrating usage
