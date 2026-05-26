import 'package:flutter/widgets.dart';
import 'package:flutter_dsl/flutter_dsl.dart';
import 'package:flutter_test/flutter_test.dart';

// Note: SizedBox and Image expose width/height as instance fields, which shadow
// the extension methods. These tests use Text — which does not — to verify the
// extension resolution.

void main() {
  test('.width / .height wrap in SizedBox', () {
    final w = const Text('x').width(100);
    expect(w, isA<SizedBox>());
    expect((w as SizedBox).width, 100);
    expect(w.height, isNull);

    final h = const Text('x').height(50);
    expect((h as SizedBox).height, 50);
    expect(h.width, isNull);
  });

  test('.size sets both dimensions', () {
    final s = const Text('x').size(120, 80);
    expect(s, isA<SizedBox>());
    expect((s as SizedBox).width, 120);
    expect(s.height, 80);
  });

  test('.square sets equal dimensions', () {
    final s = const Text('x').square(64);
    expect((s as SizedBox).width, 64);
    expect(s.height, 64);
  });

  test('.constrained applies BoxConstraints', () {
    final c = const Text('x').constrained(
      minWidth: 10,
      maxWidth: 100,
      minHeight: 20,
      maxHeight: 50,
    );
    expect(c, isA<ConstrainedBox>());
    final box = c as ConstrainedBox;
    expect(box.constraints.minWidth, 10);
    expect(box.constraints.maxWidth, 100);
    expect(box.constraints.minHeight, 20);
    expect(box.constraints.maxHeight, 50);
  });

  test('.aspectRatio wraps in AspectRatio', () {
    final a = const Text('x').aspectRatio(16 / 9);
    expect(a, isA<AspectRatio>());
    expect((a as AspectRatio).aspectRatio, 16 / 9);
  });
}
