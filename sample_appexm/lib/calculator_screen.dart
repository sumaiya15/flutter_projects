// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:sample_appexm/model.dart';


// class CalculatorScreen extends StatelessWidget {
//   const CalculatorScreen({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Calculator App'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Consumer(builder: (context, watch, child) {
//               final calculator = watch(calculatorProvider.notifier);
//               return Text(
//                 'Result: ${calculator.toStringAsFixed(2)}',
//                 textAlign: TextAlign.center,
//                 style:const TextStyle(fontSize: 24),
//               );
//             }),
//            const SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 CalculatorButton('+', () {
//                 //  context.read(calculatorProvider.notifier).add(5);
//                 }),
//                 CalculatorButton('-', () {
//                 //  context.read(calculatorProvider.notifier).subtract(5);
//                 }),
//                 CalculatorButton('*', () {
//                 //  context.read(calculatorProvider.notifier).multiply(2);
//                 }),
//                 CalculatorButton('/', () {
//                  // context.read(calculatorProvider.notifier).divide(2);
//                 }),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class CalculatorButton extends StatelessWidget {
//   final String label;
//   final Function() onPressed;

//   const CalculatorButton(this.label, this.onPressed, {super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: onPressed,
//       child: Text(label),
//     );
//   }
// }
