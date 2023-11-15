import 'package:flutter/material.dart';
import 'package:binarytree/binarytree.dart';
import 'package:binarytree/binarytreelist.dart';


void main() {
  BinaryTree tree = BinaryTree();

  // Insert values into the binary tree
  tree.insert(50);
  tree.insert(30);
  tree.insert(70);
  tree.insert(20);
  tree.insert(40);
  tree.insert(60);
  tree.insert(80);

  // Search for a specific value
  int searchValue = 50;
  bool found = tree.search(searchValue);

  runApp(MyApp(searchResult: found, tree: tree, searchValue: searchValue,));
}

class MyApp extends StatelessWidget {
  final bool searchResult;
  final BinaryTree tree;
  final int searchValue;

  const MyApp({super.key, required this.searchResult, required this.tree, required this.searchValue});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Binary Tree Search Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              const SizedBox(height: 20),
              const Text(
                'Binary Tree Elements:',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 10),
              BinaryTreeList(tree.root),
              const Text(
                'Search Result:',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                searchResult
                    ? '$searchValue found in the binary tree.'
                    : '$searchValue not found in the binary tree.',
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
