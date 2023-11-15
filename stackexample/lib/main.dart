import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Stack {
  final List<String> _items = [];
  
  void push(String item) {
    _items.add(item);
  }

    pop() {
    if (_items.isNotEmpty) {
       return _items.removeLast();
    }
    else{
      return 'NA';
    }
  }

  int size() {
    return _items.length;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Stack stack = Stack();

    stack.push('Item1');

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title:const Text('Flutter Stack Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Stack size: ${stack.size()}'),
              Text('Pop: ${stack.pop()}'),
              Text('Stack size after pops: ${stack.size()}'),
            ],
          ),
        ),
      ),
    );
  }
}
