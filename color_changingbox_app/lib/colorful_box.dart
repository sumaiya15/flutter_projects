import 'package:flutter/material.dart';
import 'dart:math';

class ColorfulBox extends StatefulWidget {
  const ColorfulBox({Key? key}) : super(key: key);

  @override
  _ColorfulBoxState createState() => _ColorfulBoxState();
}

class _ColorfulBoxState extends State<ColorfulBox> {
  Color _boxColor = Colors.blue;

  void changeColor() {
    setState(() {
      _boxColor = Color.fromARGB(
        255,
        Random().nextInt(256),
        Random().nextInt(256),
        Random().nextInt(256),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 200,
          height: 200,
          color: _boxColor,
        ),
        const SizedBox(height: 30),
        TextButton(
          onPressed: changeColor,
          style: TextButton.styleFrom(
            backgroundColor: Colors.teal,
            primary: Colors.white,
          ),
          child: const Text('Change Color'),
        ),
      ],
    );
  }
}
