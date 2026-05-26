## [1.0.0] - Major Pivot: responsive layout & design-system DX

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
