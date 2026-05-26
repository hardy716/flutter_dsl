import 'package:flutter_dsl/flutter_dsl.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Breakpoints.resolve (material3)', () {
    test('599 → compact', () {
      expect(
        Breakpoints.resolve(599, Breakpoints.material3),
        ScreenSize.compact,
      );
    });
    test('600 → medium', () {
      expect(
        Breakpoints.resolve(600, Breakpoints.material3),
        ScreenSize.medium,
      );
    });
    test('839 → medium', () {
      expect(
        Breakpoints.resolve(839, Breakpoints.material3),
        ScreenSize.medium,
      );
    });
    test('840 → expanded', () {
      expect(
        Breakpoints.resolve(840, Breakpoints.material3),
        ScreenSize.expanded,
      );
    });
    test('1199 → expanded', () {
      expect(
        Breakpoints.resolve(1199, Breakpoints.material3),
        ScreenSize.expanded,
      );
    });
    test('1200 → large', () {
      expect(
        Breakpoints.resolve(1200, Breakpoints.material3),
        ScreenSize.large,
      );
    });
    test('1599 → large', () {
      expect(
        Breakpoints.resolve(1599, Breakpoints.material3),
        ScreenSize.large,
      );
    });
    test('1600 → extraLarge', () {
      expect(
        Breakpoints.resolve(1600, Breakpoints.material3),
        ScreenSize.extraLarge,
      );
    });
  });

  group('Breakpoints.resolve (custom)', () {
    test('works with non-default thresholds', () {
      expect(
        Breakpoints.resolve(399, const [400, 800, 1200, 1600]),
        ScreenSize.compact,
      );
      expect(
        Breakpoints.resolve(400, const [400, 800, 1200, 1600]),
        ScreenSize.medium,
      );
    });

    test('asserts when breakpoints length != 4', () {
      expect(
        () => Breakpoints.resolve(100, const [600, 1200]),
        throwsA(isA<AssertionError>()),
      );
    });
  });

  group('ScreenSize getters', () {
    test('compact is mobile only', () {
      expect(ScreenSize.compact.isMobile, isTrue);
      expect(ScreenSize.compact.isTablet, isFalse);
      expect(ScreenSize.compact.isDesktop, isFalse);
    });
    test('medium and expanded are tablet', () {
      expect(ScreenSize.medium.isTablet, isTrue);
      expect(ScreenSize.expanded.isTablet, isTrue);
    });
    test('large and extraLarge are desktop', () {
      expect(ScreenSize.large.isDesktop, isTrue);
      expect(ScreenSize.extraLarge.isDesktop, isTrue);
    });
  });
}
