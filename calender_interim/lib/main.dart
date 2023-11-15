import 'package:calender_interim/screens/calender_page.dart';
import 'package:calender_interim/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.light,
    seedColor: const Color.fromARGB(255, 83, 189, 207),
  ),
);

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => CalendarData(),
      child: const MyApp(),
    ),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: theme,
       debugShowCheckedModeBanner: false,
      home:const CalendarPage(),
    );
  }
}