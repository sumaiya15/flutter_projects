import 'package:flutter/material.dart';
import 'package:openchain_task/option_chain_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: OptionChainScreen()
    );
  }
}
