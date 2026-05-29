import 'package:flutter/widgets.dart';
import 'package:flutter_dsl/flutter_dsl.dart';
import 'package:flutter_test/flutter_test.dart';

class _Capture extends ResponsiveStatelessWidget {
  final void Function(ScreenSize) onSize;
  // Exercises the deprecated per-widget `breakpoints` param to verify it still
  // works (back-compat). The recommended path is an app-level ResponsiveScope.
  // ignore: deprecated_member_use_from_same_package
  const _Capture({required this.onSize, super.breakpoints});

  @override
  Widget buildResponsive(BuildContext context, ScreenSize size) {
    onSize(size);
    return const SizedBox.shrink();
  }
}

class _CaptureStateful extends ResponsiveStatefulWidget {
  final void Function(ScreenSize) onSize;
  const _CaptureStateful({required this.onSize});

  @override
  State<_CaptureStateful> createState() => _CaptureStatefulState();
}

class _CaptureStatefulState extends ResponsiveState<_CaptureStateful> {
  @override
  Widget buildResponsive(BuildContext context, ScreenSize size) {
    widget.onSize(size);
    return const SizedBox.shrink();
  }
}

Widget _wrap(Size size, Widget child) => MediaQuery(
      data: MediaQueryData(size: size),
      child: Directionality(textDirection: TextDirection.ltr, child: child),
    );

void main() {
  testWidgets('ResponsiveStatelessWidget auto-wraps ResponsiveScope',
      (tester) async {
    ScreenSize? observed;
    await tester.pumpWidget(
      _wrap(
        const Size(900, 600),
        _Capture(onSize: (s) => observed = s),
      ),
    );
    expect(observed, ScreenSize.expanded);
  });

  testWidgets('ResponsiveStatelessWidget honors custom breakpoints',
      (tester) async {
    ScreenSize? observed;
    await tester.pumpWidget(
      _wrap(
        const Size(500, 800),
        _Capture(
          onSize: (s) => observed = s,
          breakpoints: const [400, 800, 1200, 1600],
        ),
      ),
    );
    expect(observed, ScreenSize.medium);
  });

  testWidgets('ResponsiveStatefulWidget auto-wraps ResponsiveScope',
      (tester) async {
    ScreenSize? observed;
    await tester.pumpWidget(
      _wrap(
        const Size(1300, 800),
        _CaptureStateful(onSize: (s) => observed = s),
      ),
    );
    expect(observed, ScreenSize.large);
  });
}
