import 'package:flutter/material.dart';
import 'package:flutter_dsl/flutter_dsl.dart';

void main() {
  runApp(const DSLExampleApp());
}

class DSLExampleApp extends StatelessWidget {
  const DSLExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter_dsl Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const DSLExampleHomePage(),
    );
  }
}

class DSLExampleHomePage extends StatefulWidget {
  const DSLExampleHomePage({super.key});

  @override
  State<DSLExampleHomePage> createState() => _DSLExampleHomePageState();
}

class _DSLExampleHomePageState extends State<DSLExampleHomePage> {
  bool isLoggedIn = false;
  bool hasError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('flutter_dsl Demo')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Text DSL
            'Welcome to DSL UI'
                .headlineMedium(context)
                .paddingAll(16),

            // Spacing
            Spacing.square(16),

            // Conditional rendering
            'You are logged in'
                .text(fontSize: 16, color: Colors.green)
                .visible(isLoggedIn),

            'An error occurred'
                .text(color: Colors.red)
                .visible(hasError),

            Spacing(h: 12),

            'Toggle Login'
                .text(fontSize: 16)
                .paddingAll(12)
                .backgroundColor(Colors.blue)
                .rounded(8)
                .onTap(() {
              setState(() {
                isLoggedIn = !isLoggedIn;
                hasError = false;
              });
            }),

            Spacing(h: 12),

            'Trigger Error'
                .text()
                .paddingAll(12)
                .backgroundColor(Colors.red)
                .rounded(8)
                .onTap(() {
              setState(() {
                hasError = !hasError;
              });
            }),
          ],
        ),
      ),
    );
  }
}
