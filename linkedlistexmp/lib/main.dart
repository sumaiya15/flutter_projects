import 'dart:collection';
import 'package:flutter/material.dart';

final class Entry<T> extends LinkedListEntry<Entry<T>> {
  T value;
  Entry(this.value);
  @override
  String toString() {
    return '$value';
  }
}

void main() {
  var linkedList = LinkedList<Entry<int>>();
  linkedList.add(Entry(1));
  linkedList.add(Entry(2));
  linkedList.add(Entry(3));

  runApp(MyApp(linkedList));
}

class MyApp extends StatelessWidget {
  final LinkedList<Entry<int>> linkedList;

  const MyApp(this.linkedList, {super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('LinkedList Example'),
        ),
        body: ListView(
          children: [
            ListTile(
              title: Text("Initial linkedList: $linkedList"),
            ),
            ListTile(
              title: Text("Removed element: ${linkedList.remove(linkedList.elementAt(0))}"),
            ),
            ListTile(
              title: Text("After removal: $linkedList"),
            ),
          ],
        ),
      ),
    );
  }
}
