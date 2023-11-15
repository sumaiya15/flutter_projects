import 'package:flutter/material.dart';
import 'package:binarytree/binarytree.dart';

class BinaryTreeList extends StatelessWidget {
  final TreeNode? root;

  const BinaryTreeList(this.root, {super.key});

  @override
  Widget build(BuildContext context) {
    List<int> elements = [];

    _inOrderTraversal(root, elements);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: elements.map((value) => Text(value.toString(), style: const TextStyle(fontSize: 18))).toList(),
    );
  }

  void _inOrderTraversal(TreeNode? node, List<int> elements) {
    if (node != null) {
      _inOrderTraversal(node.left, elements);
      elements.add(node.value);
      _inOrderTraversal(node.right, elements);
    }
  }
}