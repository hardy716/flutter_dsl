/// flutter_dsl: annotation + extension based responsive layout and
/// design-system-friendly DX toolkit for Flutter.
library flutter_dsl;

// Legacy 0.1.x extensions (kept methods only — deprecated portions live in
// `src/deprecated/` and are re-exported below).
export 'src/conditional_extensions.dart';
export 'src/spacing_extensions.dart';
export 'src/text_extensions.dart';
export 'src/widget_extensions.dart';
export 'src/iterable_widget_extensions.dart';

// Deprecated 0.1.x APIs (gathered under `src/deprecated/`; removal scheduled
// for v2.0). Re-exported so existing 0.1.x consumer code keeps working with
// deprecation warnings instead of compile errors.
export 'src/deprecated/widget_margin_extensions.dart';
export 'src/deprecated/string_text_extensions.dart';
export 'src/deprecated/spacing_extensions.dart';
export 'src/deprecated/conditional_extensions.dart';

// Marker annotations.
export 'src/annotations/responsive_view.dart';
export 'src/annotations/design_system_component.dart';
export 'src/annotations/breakpoint_override.dart';

// Responsive infrastructure.
export 'src/responsive/screen_size.dart';
export 'src/responsive/breakpoints.dart';
export 'src/responsive/responsive_scope.dart';
export 'src/responsive/responsive_widget.dart';
export 'src/responsive/responsive_builder.dart';
export 'src/responsive/responsive_extensions.dart';
export 'src/responsive/responsive_helpers.dart';

// Styling extensions.
export 'src/styling/widget_sizing_extensions.dart';
export 'src/styling/text_styling_extensions.dart';
export 'src/styling/widget_decoration_extensions.dart';

// Functional conditional extensions.
export 'src/conditional/functional_conditional_extensions.dart';
