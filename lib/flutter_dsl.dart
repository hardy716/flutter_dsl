/// flutter_dsl: annotation + extension based responsive layout and
/// design-system-friendly DX toolkit for Flutter.
library flutter_dsl;

// v1 extensions (kept; some methods deprecated — see CHANGELOG).
export 'src/conditional_extensions.dart';
export 'src/spacing_extensions.dart';
export 'src/text_extensions.dart';
export 'src/widget_extensions.dart';
export 'src/iterable_widget_extensions.dart';

// v2 annotations (markers).
export 'src/annotations/responsive_view.dart';
export 'src/annotations/design_system_component.dart';
export 'src/annotations/breakpoint_override.dart';

// v2 responsive infrastructure.
export 'src/responsive/screen_size.dart';
export 'src/responsive/breakpoints.dart';
export 'src/responsive/responsive_scope.dart';
export 'src/responsive/responsive_widget.dart';
export 'src/responsive/responsive_builder.dart';
export 'src/responsive/responsive_extensions.dart';
export 'src/responsive/responsive_helpers.dart';

// v2 styling extensions.
export 'src/styling/widget_sizing_extensions.dart';
export 'src/styling/text_styling_extensions.dart';

// v2 functional conditional extensions.
export 'src/conditional/conditional_v2_extensions.dart';
