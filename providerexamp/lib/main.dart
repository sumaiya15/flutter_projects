import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providerexamp/provider/example_one_provider.dart';
import 'package:providerexamp/provider/favourite_providder.dart';
import 'package:providerexamp/screens/count_example.dart';
import 'package:providerexamp/provider/count_provider.dart';
//import 'package:providerexamp/screens/favourite_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
 return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => CountProvider()),
          ChangeNotifierProvider(create: (_) => ExampleOneProvider()),
          ChangeNotifierProvider(create: (_) => FavouriteProvider()),

        ],   
         child: const MaterialApp(
      home:CountExample(),
    ),);
  }
}
