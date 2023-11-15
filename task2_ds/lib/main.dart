import 'package:flutter/material.dart';
import 'package:task2_ds/itemlist.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title:const Text('Add and Delete Items'),
        ),
        body: const ItemList(),
      ),
    );
  }
}


