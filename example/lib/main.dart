import 'package:flutter/material.dart';
import 'package:flutter_dsl/flutter_dsl.dart';

void main() => runApp(const DslExampleApp());

class DslExampleApp extends StatelessWidget {
  const DslExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter_dsl v1.0 demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      // 1) Wrap the entire app in ResponsiveScope so .onMobile / Responsive.value
      //    pick up the right ScreenSize everywhere.
      builder: (context, child) => ResponsiveScope(child: child!),
      home: const DashboardPage(),
    );
  }
}

// 2) @ResponsiveView is a marker. The companion base class
//    ResponsiveStatelessWidget actually wraps the subtree in a
//    ResponsiveScope and forwards the resolved ScreenSize to buildResponsive.
@ResponsiveView()
class DashboardPage extends ResponsiveStatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget buildResponsive(BuildContext context, ScreenSize size) {
    return Scaffold(
      appBar: AppBar(
        title: 'flutter_dsl v1.0 — ${size.name}'.titleLarge(context),
      ),
      body: const _DashboardBody(),
    );
  }
}

class _DashboardBody extends StatefulWidget {
  const _DashboardBody();

  @override
  State<_DashboardBody> createState() => _DashboardBodyState();
}

class _DashboardBodyState extends State<_DashboardBody> {
  bool highlight = false;

  @override
  Widget build(BuildContext context) {
    // 3) Responsive.value picks a value per screen size with zero wrapper
    //    widgets (no tree depth penalty).
    final pagePadding = Responsive.value(
      context,
      mobile: 16.0,
      tablet: 24.0,
      desktop: 40.0,
    );

    return Padding(
      padding: EdgeInsets.all(pagePadding),
      child: SingleChildScrollView(
        child: [
          // 4) Compact text styling — design-system token + per-property overrides.
          'flutter_dsl v1.0'
              .headlineMedium(context)
              .fontSize(32)
              .textColor(Theme.of(context).colorScheme.primary),

          const Spacing(h: 8),
          'Responsive layout + design-system DX without build_runner.'
              .bodyLarge(context)
              .lineHeight(1.5),

          const Spacing(h: 24),

          // 5) ResponsiveBuilder — alternative to chaining when you need
          //    completely different subtrees per size.
          ResponsiveBuilder(
            mobile: (c) => const _StatCard(label: 'Mobile layout'),
            tablet: (c) => [
              const _StatCard(label: 'Visits', value: '1.2k').expanded(),
              const _StatCard(label: 'Signups', value: '83').expanded(),
            ].row(spacing: 16),
            desktop: (c) => [
              const _StatCard(label: 'Visits', value: '1.2k').expanded(),
              const _StatCard(label: 'Signups', value: '83').expanded(),
              const _StatCard(label: 'Revenue', value: '\$2.4k').expanded(),
              const _StatCard(label: 'Errors', value: '0').expanded(),
            ].row(spacing: 16),
          ),

          const Spacing(h: 24),

          // 6) Chainable responsive transforms via .onMobile / .onDesktop and
          //    .hideOnMobile.
          'Hide me on mobile, scale me up on desktop.'
              .bodyMedium(context)
              .paddingAll(16)
              .backgroundColor(
                Theme.of(context).colorScheme.surfaceContainerHigh,
              )
              .rounded(12)
              .onDesktop(
                (w) => w.padding(
                  const EdgeInsets.symmetric(horizontal: 48, vertical: 24),
                ),
              )
              .hideOnMobile(),

          const Spacing(h: 24),

          // 7) Functional conditional transform (.onTrue).
          //    Keep visibility logic (.visible) and transform logic (.onTrue) apart.
          'Tap below to toggle highlight transform.'
              .labelLarge(context)
              .paddingAll(12)
              .onTrue(
                highlight,
                (w) => w.backgroundColor(
                  Theme.of(context).colorScheme.tertiaryContainer,
                ),
              )
              .rounded(8)
              .onTap(() => setState(() => highlight = !highlight)),

          const Spacing(h: 24),

          // 8) Value-dispatched WhenWidget.
          WhenWidget<bool>(
            value: highlight,
            cases: {
              true: () =>
                  'Highlighted!'.titleMedium(context).textColor(Colors.green),
              false: () => 'Not highlighted'.titleMedium(context).italic(),
            },
          ),
        ].column(crossAxisAlignment: CrossAxisAlignment.start),
      ),
    );
  }
}

// Small helper so .onDesktop has something to chain onto in (6).
extension on Widget {
  Widget padding(EdgeInsetsGeometry value) =>
      Padding(padding: value, child: this);
}

class _StatCard extends StatelessWidget {
  final String label;
  final String? value;
  const _StatCard({required this.label, this.value});

  @override
  Widget build(BuildContext context) {
    return [
      label.labelMedium(context),
      const Spacing(h: 4),
      (value ?? '—').headlineSmall(context).fontWeight(FontWeight.bold),
    ]
        .column(crossAxisAlignment: CrossAxisAlignment.start)
        .paddingAll(16)
        .backgroundColor(Theme.of(context).colorScheme.surfaceContainerLow)
        .rounded(12);
  }
}
