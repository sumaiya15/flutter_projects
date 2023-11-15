import 'package:flutter/material.dart';
import 'package:color_changingbox_app/colorful_box.dart'; // Correct the import path if needed.

void main() {
  runApp(const MaterialApp(
    home: Scaffold(
      // backgroundColor: Color.fromARGB(225, 330r, g, b),
      //appBar: AppBar(title: const Text('Colorful Box')),
      body: Center(child: ColorfulBox()),
    ),
  ));
}
