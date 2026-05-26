import 'package:flutter_dsl/flutter_dsl.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('ResponsiveView defaults to material3 breakpoints', () {
    const r = ResponsiveView();
    expect(r.breakpoints, const [600, 840, 1200, 1600]);
  });

  test('ResponsiveView accepts custom breakpoints', () {
    const r = ResponsiveView(breakpoints: [400, 800, 1200, 1600]);
    expect(r.breakpoints, const [400, 800, 1200, 1600]);
  });

  test('DesignSystemComponent stores name and category', () {
    const d =
        DesignSystemComponent(name: 'PrimaryButton', category: 'actions');
    expect(d.name, 'PrimaryButton');
    expect(d.category, 'actions');
  });

  test('DesignSystemComponent fields are nullable', () {
    const d = DesignSystemComponent();
    expect(d.name, isNull);
    expect(d.category, isNull);
  });

  test('BreakpointOverride stores breakpoints', () {
    const b = BreakpointOverride([200, 500, 900, 1400]);
    expect(b.breakpoints, const [200, 500, 900, 1400]);
  });
}
