// flutter_dsl • Core API showcase.
//
// Five tabs (Responsive / Styling / Text / Conditional / Layout) each
// demonstrate a category of Core APIs with a live widget + the code that
// produced it. Resize the window to see responsive features react; toggle the
// switches on the Conditional tab to exercise transform-based helpers.

import 'package:flutter/material.dart';
import 'package:flutter_dsl/flutter_dsl.dart';

void main() => runApp(const FlutterDslShowcase());

class FlutterDslShowcase extends StatelessWidget {
  const FlutterDslShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter_dsl • Core API showcase',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      // Wrap once so every descendant can call Responsive.* / .onMobile /
      // .hideOnDesktop / .responsive / etc.
      builder: (context, child) => ResponsiveScope(child: child!),
      home: const ShowcasePage(),
    );
  }
}

/// `@ResponsiveView` is a declarative marker; pairing it with
/// [ResponsiveStatelessWidget] makes the declared `breakpoints` take effect —
/// the base class auto-wraps the subtree in a [ResponsiveScope] and forwards
/// the current [ScreenSize] to [buildResponsive].
@ResponsiveView()
@DesignSystemComponent(name: 'ShowcasePage', category: 'screens')
class ShowcasePage extends ResponsiveStatelessWidget {
  const ShowcasePage({super.key});

  @override
  Widget buildResponsive(BuildContext context, ScreenSize size) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('flutter_dsl • Core APIs'),
          actions: [
            _ScreenSizeChip(size: size),
            const SizedBox(width: 12),
          ],
          bottom: const TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            tabs: [
              Tab(icon: Icon(Icons.devices), text: 'Responsive'),
              Tab(icon: Icon(Icons.style), text: 'Styling'),
              Tab(icon: Icon(Icons.text_fields), text: 'Text'),
              Tab(icon: Icon(Icons.toggle_on), text: 'Conditional'),
              Tab(icon: Icon(Icons.view_array), text: 'Layout'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _ResponsiveTab(),
            _StylingTab(),
            _TextTab(),
            _ConditionalTab(),
            _LayoutTab(),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// Reusable showcase helpers
// ============================================================================

class _SectionHeader extends StatelessWidget {
  final String title;
  final String description;
  const _SectionHeader({required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return [
      title.titleMedium(context).fontWeight(FontWeight.w700),
      description.bodySmall(context).textColor(
            Theme.of(context).colorScheme.onSurfaceVariant,
          ),
    ]
        .column(crossAxisAlignment: CrossAxisAlignment.start, spacing: 2)
        .paddingOnly(top: 20, bottom: 8, left: 4, right: 4);
  }
}

class _DemoCard extends StatelessWidget {
  final Widget child;
  final String? code;
  const _DemoCard({required this.child, this.code});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: [
        child,
        if (code != null) _CodeBlock(code: code!),
      ]
          .column(crossAxisAlignment: CrossAxisAlignment.start, spacing: 12)
          .paddingAll(16),
    );
  }
}

class _CodeBlock extends StatelessWidget {
  final String code;
  const _CodeBlock({required this.code});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SelectableText(
        code,
        style: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 12,
          height: 1.5,
        ),
      )
          .paddingAll(12)
          .backgroundColor(
              Theme.of(context).colorScheme.surfaceContainerHighest)
          .rounded(8),
    );
  }
}

class _ScreenSizeChip extends StatelessWidget {
  final ScreenSize size;
  const _ScreenSizeChip({required this.size});

  @override
  Widget build(BuildContext context) {
    final (color, icon) = switch (size) {
      ScreenSize.compact => (Colors.green, Icons.smartphone),
      ScreenSize.medium => (Colors.cyan, Icons.tablet_mac),
      ScreenSize.expanded => (Colors.blue, Icons.tablet),
      ScreenSize.large => (Colors.indigo, Icons.laptop),
      ScreenSize.extraLarge => (Colors.purple, Icons.desktop_windows),
    };
    return Chip(
      avatar: Icon(icon, color: color, size: 18),
      label: Text(
        size.name,
        style: TextStyle(fontWeight: FontWeight.w700, color: color),
      ),
      backgroundColor: color.withValues(alpha: 0.12),
      side: BorderSide(color: color.withValues(alpha: 0.4)),
    );
  }
}

// ============================================================================
// Tab 1 — Responsive
// ============================================================================

class _ResponsiveTab extends StatelessWidget {
  const _ResponsiveTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          color: Theme.of(context).colorScheme.tertiaryContainer,
          child: ListTile(
            leading: Icon(
              Icons.swap_horiz,
              color: Theme.of(context).colorScheme.onTertiaryContainer,
            ),
            title: 'Resize the window'
                .titleSmall(context)
                .fontWeight(FontWeight.bold),
            subtitle:
                ('Most demos below react to the current width. Drag the window '
                        'edge to slide between compact / medium / expanded / large '
                        '/ extraLarge.')
                    .bodySmall(context),
          ),
        ),
        const _SectionHeader(
          title: 'ResponsiveBuilder',
          description:
              'Picks a builder per ScreenSize with desktop → tablet → mobile fallback.',
        ),
        _DemoCard(
          code: 'ResponsiveBuilder(\n'
              '  mobile:  (_) => MobileLayout(),\n'
              '  tablet:  (_) => TabletLayout(),\n'
              '  desktop: (_) => DesktopLayout(),\n'
              ')',
          child: ResponsiveBuilder(
            mobile: (_) =>
                const _LabeledBox(label: 'mobile layout', color: Colors.green),
            tablet: (_) =>
                const _LabeledBox(label: 'tablet layout', color: Colors.blue),
            desktop: (_) => const _LabeledBox(
                label: 'desktop layout', color: Colors.purple),
          ),
        ),
        const _SectionHeader(
          title: 'Responsive.value<T>',
          description:
              'Picks any value (here padding) per screen size — no wrapper widget added.',
        ),
        Builder(
          builder: (ctx) {
            final padding = Responsive.value(
              ctx,
              mobile: 8.0,
              tablet: 16.0,
              desktop: 32.0,
            );
            return _DemoCard(
              code: 'Responsive.value(context,\n'
                  '  mobile: 8.0, tablet: 16.0, desktop: 32.0,\n'
                  ')',
              child: 'padding = ${padding.toInt()}px'
                  .bodyMedium(ctx)
                  .paddingAll(padding)
                  .backgroundColor(Theme.of(ctx).colorScheme.primaryContainer)
                  .rounded(8),
            );
          },
        ),
        const _SectionHeader(
          title: 'Responsive.when + isMobile/Tablet/Desktop',
          description:
              'Context-aware widget picker and screen-size flags. Zero wrappers.',
        ),
        _DemoCard(
          code: 'Responsive.isMobile(context)\n'
              'Responsive.when(\n'
              '  context,\n'
              '  mobile: …, tablet: …, desktop: …,\n'
              ')',
          child: [
            'isMobile = ${Responsive.isMobile(context)}'.bodyMedium(context),
            'isTablet = ${Responsive.isTablet(context)}'.bodyMedium(context),
            'isDesktop = ${Responsive.isDesktop(context)}'.bodyMedium(context),
            const Spacing(h: 8),
            Responsive.when(
              context,
              mobile:
                  const Icon(Icons.smartphone, size: 48, color: Colors.green),
              tablet: const Icon(Icons.tablet, size: 48, color: Colors.blue),
              desktop: const Icon(Icons.desktop_windows,
                  size: 48, color: Colors.purple),
            ),
          ].column(crossAxisAlignment: CrossAxisAlignment.start, spacing: 4),
        ),
        const _SectionHeader(
          title: '.onMobile / .onTablet / .onDesktop',
          description: 'Chainable transforms applied only on matching size.',
        ),
        _DemoCard(
          code: 'widget\n'
              '  .onMobile((w) => w.paddingAll(16))\n'
              '  .onDesktop((w) => w.constrained(maxWidth: 320))',
          child: 'I transform per size'
              .bodyMedium(context)
              .paddingAll(8)
              .backgroundColor(Theme.of(context).colorScheme.secondaryContainer)
              .rounded(8)
              .onMobile((w) => w.paddingAll(16))
              .onDesktop((w) => w.constrained(maxWidth: 320)),
        ),
        const _SectionHeader(
          title: '.hideOnMobile / .hideOnTablet / .hideOnDesktop',
          description: 'Shrink to SizedBox.shrink on matching size.',
        ),
        _DemoCard(
          code: 'widget.hideOnMobile()\n'
              'widget.hideOnTablet()\n'
              'widget.hideOnDesktop()',
          child: [
            'Always visible'.bodyMedium(context),
            'Hidden on mobile'
                .bodyMedium(context)
                .textColor(Colors.green)
                .hideOnMobile(),
            'Hidden on tablet'
                .bodyMedium(context)
                .textColor(Colors.blue)
                .hideOnTablet(),
            'Hidden on desktop'
                .bodyMedium(context)
                .textColor(Colors.purple)
                .hideOnDesktop(),
          ].column(crossAxisAlignment: CrossAxisAlignment.start, spacing: 4),
        ),
        const _SectionHeader(
          title: '.responsive({mobile, tablet, desktop})',
          description:
              'Pick a wrap function per size in a single chained call.',
        ),
        _DemoCard(
          code: 'widget.responsive(\n'
              '  mobile:  (w) => w.backgroundColor(green),\n'
              '  tablet:  (w) => w.backgroundColor(blue),\n'
              '  desktop: (w) => w.backgroundColor(purple),\n'
              ')',
          child: 'background follows current ScreenSize'
              .bodyMedium(context)
              .paddingAll(12)
              .rounded(8)
              .responsive(
                mobile: (w) => w.backgroundColor(Colors.green.shade100),
                tablet: (w) => w.backgroundColor(Colors.blue.shade100),
                desktop: (w) => w.backgroundColor(Colors.purple.shade100),
              ),
        ),
        const _SectionHeader(
          title: 'ResponsiveScope.dataOf(context)',
          description:
              'Direct readout of the current ScreenSize / width / breakpoints.',
        ),
        Builder(
          builder: (ctx) {
            final data = ResponsiveScope.dataOf(ctx);
            return _DemoCard(
              code: 'final data = ResponsiveScope.dataOf(context);',
              child: [
                'size: ${data.size.name}'.bodyMedium(ctx),
                'width: ${data.width.toInt()}px'.bodyMedium(ctx),
                'breakpoints: ${data.breakpoints}'.bodyMedium(ctx),
              ].column(
                  crossAxisAlignment: CrossAxisAlignment.start, spacing: 4),
            );
          },
        ),
        const _SectionHeader(
          title: 'Marker annotations',
          description:
              'Documentation markers (no runtime effect). Pair @ResponsiveView with the base class for resolution; set breakpoints once on the app-level ResponsiveScope.',
        ),
        _DemoCard(
          code: '@ResponsiveView()\n'
              "@DesignSystemComponent(name: 'ShowcasePage')\n"
              'class ShowcasePage extends ResponsiveStatelessWidget {\n'
              '  …\n'
              '}',
          child:
              ('This very page uses `ResponsiveStatelessWidget` as its base, so '
                      'it resolves the current `ScreenSize` from the app-level '
                      '`ResponsiveScope` (the single source of truth for '
                      'breakpoints). A `ResponsiveStatefulWidget` + '
                      '`ResponsiveState<T>` pair is also available for stateful '
                      'screens.')
                  .bodyMedium(context),
        ),
      ],
    );
  }
}

class _LabeledBox extends StatelessWidget {
  final String label;
  final Color color;
  const _LabeledBox({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return label
        .bodyLarge(context)
        .fontWeight(FontWeight.w600)
        .textColor(Colors.white)
        .center()
        .paddingAll(20)
        .backgroundColor(color)
        .rounded(8);
  }
}

// ============================================================================
// Tab 2 — Styling
// ============================================================================

class _StylingTab extends StatelessWidget {
  const _StylingTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _SectionHeader(
          title: '.paddingAll / .paddingSymmetric / .paddingOnly',
          description: 'Wrap in Padding without nesting.',
        ),
        _DemoCard(
          code: 'widget.paddingAll(16)\n'
              'widget.paddingSymmetric(horizontal: 24, vertical: 4)\n'
              'widget.paddingOnly(left: 32, top: 8)',
          child: [
            'paddingAll(16)'
                .bodyMedium(context)
                .paddingAll(16)
                .backgroundColor(Colors.amber.shade100),
            'paddingSymmetric(h: 24, v: 4)'
                .bodyMedium(context)
                .paddingSymmetric(horizontal: 24, vertical: 4)
                .backgroundColor(Colors.green.shade100),
            'paddingOnly(left: 32, top: 8)'
                .bodyMedium(context)
                .paddingOnly(left: 32, top: 8)
                .backgroundColor(Colors.blue.shade100),
          ].column(spacing: 8, crossAxisAlignment: CrossAxisAlignment.start),
        ),
        const _SectionHeader(
          title: '.rounded(radius) + .backgroundColor(color)',
          description: 'ClipRRect + ColoredBox (lighter than Container).',
        ),
        _DemoCard(
          code: 'widget.backgroundColor(color).rounded(radius)',
          child: [
            for (final r in [4.0, 12.0, 24.0])
              'r=$r'
                  .bodyMedium(context)
                  .fontWeight(FontWeight.bold)
                  .textColor(Colors.white)
                  .paddingAll(14)
                  .backgroundColor(Theme.of(context).colorScheme.primary)
                  .rounded(r),
          ].row(spacing: 8, mainAxisAlignment: MainAxisAlignment.start),
        ),
        const _SectionHeader(
          title: '.center / .align',
          description: 'Wrap in Center or Align(Alignment).',
        ),
        _DemoCard(
          code: 'widget.center()\n'
              'widget.align(Alignment.bottomRight)',
          child: SizedBox(
            height: 100,
            child: Stack(children: [
              'centered'
                  .bodyMedium(context)
                  .paddingAll(6)
                  .backgroundColor(Colors.amber.shade100)
                  .rounded(4)
                  .center(),
              'bottom right'
                  .bodySmall(context)
                  .paddingAll(6)
                  .backgroundColor(Colors.green.shade100)
                  .rounded(4)
                  .align(Alignment.bottomRight),
            ]),
          ),
        ),
        const _SectionHeader(
          title: 'Sizing chain',
          description:
              '.size / .width / .height / .square / .constrained / .aspectRatio — compact wrappers for SizedBox / ConstrainedBox / AspectRatio.',
        ),
        _DemoCard(
          code: 'widget.square(48)\n'
              'widget.size(80, 48)\n'
              'widget.aspectRatio(2).width(96)\n'
              'widget.constrained(maxWidth: 200)',
          child: [
            const ColoredBox(color: Colors.red).square(48),
            const ColoredBox(color: Colors.green).size(80, 48),
            const ColoredBox(color: Colors.blue).aspectRatio(2).width(96),
          ].row(spacing: 8, mainAxisAlignment: MainAxisAlignment.start),
        ),
        const _SectionHeader(
          title: '.onTap(callback)',
          description: 'Wrap in GestureDetector. Try tapping the chip.',
        ),
        const _OnTapDemo(),
      ],
    );
  }
}

class _OnTapDemo extends StatefulWidget {
  const _OnTapDemo();

  @override
  State<_OnTapDemo> createState() => _OnTapDemoState();
}

class _OnTapDemoState extends State<_OnTapDemo> {
  int taps = 0;

  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      code: 'widget.onTap(() => setState(() => taps++))',
      child: 'tapped $taps times'
          .bodyLarge(context)
          .fontWeight(FontWeight.w600)
          .textColor(Theme.of(context).colorScheme.onPrimaryContainer)
          .paddingAll(16)
          .backgroundColor(Theme.of(context).colorScheme.primaryContainer)
          .rounded(12)
          .onTap(() => setState(() => taps++)),
    );
  }
}

// ============================================================================
// Tab 3 — Text
// ============================================================================

class _TextTab extends StatelessWidget {
  const _TextTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _SectionHeader(
          title: 'Theme text tokens (12)',
          description:
              'String → Text using Theme.textTheme.* — no manual TextStyle.',
        ),
        _DemoCard(
          code: "'Title'.headlineLarge(context)\n"
              "'Body'.bodyMedium(context)\n"
              '// 12 methods: headline*/title*/body*/label* × Large/Medium/Small',
          child: [
            'headlineLarge'.headlineLarge(context),
            'headlineMedium'.headlineMedium(context),
            'headlineSmall'.headlineSmall(context),
            'titleLarge'.titleLarge(context),
            'titleMedium'.titleMedium(context),
            'titleSmall'.titleSmall(context),
            'bodyLarge'.bodyLarge(context),
            'bodyMedium'.bodyMedium(context),
            'bodySmall'.bodySmall(context),
            'labelLarge'.labelLarge(context),
            'labelMedium'.labelMedium(context),
            'labelSmall'.labelSmall(context),
          ].column(crossAxisAlignment: CrossAxisAlignment.start, spacing: 6),
        ),
        const _SectionHeader(
          title: '.fontSize / .fontWeight / .textColor',
          description:
              'Chained TextStyle merges on top of a theme token. Original style fields are preserved.',
        ),
        _DemoCard(
          code: "'Hello, World'.titleLarge(context)\n"
              '  .fontSize(36)\n'
              '  .fontWeight(FontWeight.w800)\n'
              '  .textColor(Theme.colorScheme.primary)',
          child: 'Hello, World'
              .titleLarge(context)
              .fontSize(36)
              .fontWeight(FontWeight.w800)
              .textColor(Theme.of(context).colorScheme.primary),
        ),
        const _SectionHeader(
          title: '.italic / .underline / .letterSpacing / .lineHeight',
          description: 'More TextStyle deltas chainable on a Text.',
        ),
        _DemoCard(
          code: 'text.italic()\n'
              'text.underline()\n'
              'text.letterSpacing(4)\n'
              'text.lineHeight(2)',
          child: [
            'italic'.bodyLarge(context).italic(),
            'underline'.bodyLarge(context).underline(),
            'l e t t e r  s p a c e d'.bodyLarge(context).letterSpacing(4),
            'line\nheight\nmultiplier'.bodyLarge(context).lineHeight(2),
          ].column(crossAxisAlignment: CrossAxisAlignment.start, spacing: 8),
        ),
      ],
    );
  }
}

// ============================================================================
// Tab 4 — Conditional
// ============================================================================

class _ConditionalTab extends StatefulWidget {
  const _ConditionalTab();

  @override
  State<_ConditionalTab> createState() => _ConditionalTabState();
}

enum _Status { ready, loading, error }

class _ConditionalTabState extends State<_ConditionalTab> {
  bool isVisible = true;
  bool isHighlighted = false;
  bool isError = false;
  bool isWarning = false;
  _Status status = _Status.ready;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _SectionHeader(
          title: '.visible(bool)',
          description: 'Returns SizedBox.shrink when false.',
        ),
        _DemoCard(
          code: 'widget.visible(isVisible)',
          child: [
            SwitchListTile(
              value: isVisible,
              title: const Text('isVisible'),
              contentPadding: EdgeInsets.zero,
              onChanged: (v) => setState(() => isVisible = v),
            ),
            'I am the widget'
                .bodyLarge(context)
                .paddingAll(12)
                .backgroundColor(
                    Theme.of(context).colorScheme.tertiaryContainer)
                .rounded(8)
                .visible(isVisible),
          ].column(crossAxisAlignment: CrossAxisAlignment.start, spacing: 8),
        ),
        const _SectionHeader(
          title: '.onTrue / .onFalse',
          description:
              'Apply a transform only when the condition matches. Returns original otherwise.',
        ),
        _DemoCard(
          code: 'card\n'
              '  .onTrue(isHighlighted,\n'
              '    (w) => w.backgroundColor(Colors.yellow))\n'
              '  .onFalse(isHighlighted,\n'
              '    (w) => w.backgroundColor(surface))',
          child: [
            SwitchListTile(
              value: isHighlighted,
              title: const Text('isHighlighted'),
              contentPadding: EdgeInsets.zero,
              onChanged: (v) => setState(() => isHighlighted = v),
            ),
            'background depends on toggle'
                .bodyLarge(context)
                .paddingAll(16)
                .rounded(12)
                .onTrue(
                  isHighlighted,
                  (w) => w.backgroundColor(Colors.yellow.shade300),
                )
                .onFalse(
                  isHighlighted,
                  (w) => w.backgroundColor(
                    Theme.of(context).colorScheme.surfaceContainer,
                  ),
                ),
          ].column(crossAxisAlignment: CrossAxisAlignment.start, spacing: 8),
        ),
        const _SectionHeader(
          title: '.when({bool: transform, …})',
          description:
              'First true case wins. Falls through to original if none match.',
        ),
        _DemoCard(
          code: 'card.when({\n'
              '  isError:   (w) => w.backgroundColor(Colors.red.shade100),\n'
              '  isWarning: (w) => w.backgroundColor(Colors.orange.shade100),\n'
              '})',
          child: [
            SwitchListTile(
              value: isError,
              title: const Text('isError (wins over isWarning)'),
              contentPadding: EdgeInsets.zero,
              onChanged: (v) => setState(() => isError = v),
            ),
            SwitchListTile(
              value: isWarning,
              title: const Text('isWarning'),
              contentPadding: EdgeInsets.zero,
              onChanged: (v) => setState(() => isWarning = v),
            ),
            'level: ${isError ? 'error' : isWarning ? 'warning' : 'normal'}'
                .bodyLarge(context)
                .paddingAll(16)
                .rounded(12)
                .when({
              isError: (w) => w.backgroundColor(Colors.red.shade100),
              isWarning: (w) => w.backgroundColor(Colors.orange.shade100),
            }),
          ].column(crossAxisAlignment: CrossAxisAlignment.start, spacing: 4),
        ),
        const _SectionHeader(
          title: 'WhenWidget<T>',
          description: 'Value-dispatched widget switch with optional orElse.',
        ),
        _DemoCard(
          code: 'WhenWidget<Status>(\n'
              '  value: status,\n'
              '  cases: {\n'
              '    Status.ready:   () => Icon(Icons.check_circle),\n'
              '    Status.loading: () => CircularProgressIndicator(),\n'
              '    Status.error:   () => Icon(Icons.error),\n'
              '  },\n'
              ')',
          child: [
            SegmentedButton<_Status>(
              segments: const [
                ButtonSegment(
                  value: _Status.ready,
                  label: Text('ready'),
                  icon: Icon(Icons.check_circle),
                ),
                ButtonSegment(
                  value: _Status.loading,
                  label: Text('loading'),
                  icon: Icon(Icons.refresh),
                ),
                ButtonSegment(
                  value: _Status.error,
                  label: Text('error'),
                  icon: Icon(Icons.error),
                ),
              ],
              selected: {status},
              onSelectionChanged: (s) => setState(() => status = s.first),
            ),
            WhenWidget<_Status>(
              value: status,
              cases: {
                _Status.ready: () => const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 48,
                    ),
                _Status.loading: () => const SizedBox(
                      width: 48,
                      height: 48,
                      child: CircularProgressIndicator(),
                    ),
                _Status.error: () => const Icon(
                      Icons.error,
                      color: Colors.red,
                      size: 48,
                    ),
              },
            ).center(),
          ].column(crossAxisAlignment: CrossAxisAlignment.stretch, spacing: 16),
        ),
      ],
    );
  }
}

// ============================================================================
// Tab 5 — Layout
// ============================================================================

class _LayoutTab extends StatelessWidget {
  const _LayoutTab();

  @override
  Widget build(BuildContext context) {
    Widget box(Color c) => ColoredBox(color: c).square(28);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _SectionHeader(
          title: 'Spacing widget',
          description:
              'Fixed gap between siblings. Factories: square / horizontal / vertical / none.',
        ),
        _DemoCard(
          code: 'Spacing(w: 16)        // horizontal gap\n'
              'Spacing(h: 16)        // vertical gap\n'
              'Spacing.square(24)\n'
              'Spacing.none()',
          child: [
            Row(
              children: [
                box(Colors.indigo),
                const Spacing(w: 8),
                box(Colors.indigo),
                const Spacing(w: 24),
                box(Colors.indigo),
                const Spacing(w: 48),
                box(Colors.indigo),
              ],
            ),
            'gaps: 8, 24, 48 px'.bodySmall(context),
          ].column(crossAxisAlignment: CrossAxisAlignment.start, spacing: 8),
        ),
        const _SectionHeader(
          title: 'Iterable<Widget>.row / .column',
          description:
              'Build a Row/Column from a list with a built-in `spacing` parameter.',
        ),
        _DemoCard(
          code: '[a, b, c].row(spacing: 8)\n'
              '[a, b, c].column(spacing: 4, crossAxisAlignment: …)',
          child: [
            [
              const Icon(Icons.star, color: Colors.amber),
              'Rated 4.9'.bodyMedium(context),
              const Icon(Icons.thumb_up, color: Colors.blue),
              '1.2k likes'.bodyMedium(context),
            ].row(spacing: 8),
            [
              'first'.bodyMedium(context).fontWeight(FontWeight.bold),
              'second'.bodyMedium(context),
              'third'.bodyMedium(context),
            ].column(spacing: 4, crossAxisAlignment: CrossAxisAlignment.start),
          ].column(crossAxisAlignment: CrossAxisAlignment.start, spacing: 16),
        ),
        const _SectionHeader(
          title: '.expanded / .flex',
          description: 'Children claim available space inside a Row/Column.',
        ),
        _DemoCard(
          code: '[\n'
              '  a.expanded(),\n'
              '  b.flex(2),\n'
              '  c.expanded(),\n'
              '].row()',
          child: SizedBox(
            height: 56,
            child: [
              'flex 1'
                  .bodyMedium(context)
                  .textColor(Colors.white)
                  .center()
                  .backgroundColor(Colors.red)
                  .expanded(),
              'flex 2'
                  .bodyMedium(context)
                  .textColor(Colors.white)
                  .center()
                  .backgroundColor(Colors.amber.shade700)
                  .flex(2),
              'flex 1'
                  .bodyMedium(context)
                  .textColor(Colors.white)
                  .center()
                  .backgroundColor(Colors.green)
                  .expanded(),
            ].row(),
          ),
        ),
      ],
    );
  }
}
