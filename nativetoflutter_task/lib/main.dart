import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: WatchlistScreen(),
    );
  }
}

class WatchlistScreen extends StatelessWidget {
  const WatchlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Use MethodChannel to communicate with native Android
            const MethodChannel('com.example/flutter_watchlist')
                .invokeMethod('navigateToLogin');
          },
          child: const Text('Back to Login'),
        ),
      ),
    );
  }
}
