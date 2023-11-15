class TreeNode {
  int value;
  TreeNode? left;
  TreeNode? right;

  TreeNode(this.value);
}

class BinaryTree {
  TreeNode? root;

  BinaryTree() {
    root = null;
  }

  // Insert a value into the binary tree
  void insert(int value) {
    root = _insertRec(root, value);
  }

  TreeNode? _insertRec(TreeNode? root, int value) {
    if (root == null) {
      root = TreeNode(value);
      return root;
    }

    if (value < root.value) {
      root.left = _insertRec(root.left, value);
    } else if (value > root.value) {
      root.right = _insertRec(root.right, value);
    }

    return root;
  }

  // Search for a value in the binary tree
  bool search(int value) {
    return _searchRec(root, value);
  }

  bool _searchRec(TreeNode? node, int value) {
    if (node == null) {
      return false;
    }

    if (node.value == value) {
      return true;
    } else if (value < node.value) {
      return _searchRec(node.left, value);
    } else {
      return _searchRec(node.right, value);
    }
  }
}
