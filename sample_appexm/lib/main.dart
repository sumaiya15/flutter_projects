import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  double _result = 0.0;

  void _add(double value) {
    setState(() {
      _result += value;
    });
  }

  void _subtract(double value) {
    setState(() {
      _result -= value;
    });
  }

  void _multiply(double value) {
    setState(() {
      _result *= value;
    });
  }

  void _divide(double value) {
    if (value != 0) {
      setState(() {
        _result /= value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Result: ${_result.toStringAsFixed(2)}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CalculatorButton('+', () {
                  _add(5);
                }),
                CalculatorButton('-', () {
                  _subtract(5);
                }),
                CalculatorButton('*', () {
                  _multiply(2);
                }),
                CalculatorButton('/', () {
                  _divide(2);
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CalculatorButton extends StatelessWidget {
  final String label;
  final Function() onPressed;

  const CalculatorButton(this.label, this.onPressed, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
