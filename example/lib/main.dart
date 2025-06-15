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
            // Title
            'Welcome to flutter_dsl'
                .headlineMedium(context)
                .paddingAll(16)
                .gapBottom(16),

            // Logged in message
            '✅ You are logged in'
                .text(fontSize: 16, color: Colors.green)
                .ifTrue(isLoggedIn)
                .gapBottom(8),

            // Error message
            '⚠️ An error occurred'
                .text(fontSize: 16, color: Colors.red)
                .ifTrue(hasError)
                .gapBottom(16),

            // Toggle login button
            _dslButton(
              text: isLoggedIn ? 'Logout' : 'Login',
              color: Colors.blue,
              onTap: () {
                setState(() {
                  isLoggedIn = !isLoggedIn;
                  hasError = false;
                });
              },
            ).gapBottom(12),

            // Trigger error button
            _dslButton(
              text: hasError ? 'Clear Error' : 'Trigger Error',
              color: Colors.red,
              onTap: () {
                setState(() {
                  hasError = !hasError;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _dslButton({
    required String text,
    required Color color,
    required VoidCallback onTap,
  }) {
    return text
        .text(color: Colors.white)
        .paddingAll(12)
        .backgroundColor(color)
        .rounded(8)
        .onTap(onTap);
  }
}
