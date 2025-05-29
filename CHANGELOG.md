## [0.1.2+1]

### Documentation

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
