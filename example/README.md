# flutter_dsl example

A five-tab showcase of [`flutter_dsl`](https://pub.dev/packages/flutter_dsl)'s Core APIs —
**Responsive**, **Styling**, **Text**, **Conditional**, and **Layout** — each pairing a live
widget with the code that produced it. The app is wrapped once in a `ResponsiveScope` and a
`DesignTokensScope`, and registers a couple of components in `DesignSystemCatalog`.

Run it, then resize the window to watch the responsive helpers, design tokens, and
`.box(...)` styling react:

```bash
flutter run            # or: flutter run -d chrome
```

See [`lib/main.dart`](lib/main.dart) for the full source.
