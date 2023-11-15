import 'package:finalsampleexample/screens/calendargrid.dart';
import 'package:finalsampleexample/screens/customappbar.dart';
import 'package:finalsampleexample/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.light,
    seedColor: const Color.fromARGB(255, 131, 57, 0),
  ),
);

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => CalendarData(),
      child: const CalendarApp(),
    ),);
}

class CalendarApp extends StatelessWidget {
  const CalendarApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: const Scaffold(
        appBar: CustomAppBar(),
        body: CalendarGrid(),
      ),
    );
  }
}
