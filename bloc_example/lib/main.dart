import 'package:bloc_example/DisplayList_Bloc/bloc.dart';
import 'package:bloc_example/DisplayList_Bloc/display_list.dart';
import 'package:bloc_example/counter_example/home_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final inputBloc = InputBloc();

    return MaterialApp(
      home: BlocProvider(
        create: (context) => inputBloc,
        child: DisplayList(),
      ),
    );
  }
}

class MyApp1 extends StatelessWidget {
  const MyApp1({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home:  MyHomePage(),
    );
  }
}

