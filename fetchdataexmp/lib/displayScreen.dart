import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DisplayScreen extends StatefulWidget {
  const DisplayScreen({super.key});

  @override
  State<DisplayScreen> createState() => _DisplayScreen();
}

class _DisplayScreen extends State<DisplayScreen> {
  List<dynamic> products = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Display Products from the API'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          final name = product['title'];
          final category = product['category'];
          final imageUrl = product['image'];
          return ListTile(
            leading: Container(
              width: 80,
              height: 80,
              child: Image.network(
                imageUrl,
                fit: BoxFit.contain,
              ),
            ),
            title: Text(name),
            subtitle: Text(category),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                // Call deleteProduct method here and pass the product ID
                deleteProduct(product['id']);
              },
            ),
          );
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: fetchProducts,
            child: const Icon(Icons.refresh),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            onPressed: () {
              // Call createProduct method here to add a new product
              createProduct({
                'title': 'New Product',
                'category': 'New Category',
                'image': 'https://example.com/new-product-image.jpg',
              });
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void fetchProducts() async {
    print('fetchProducts called');
    const url = 'https://fakestoreapi.com/products';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    if (response.statusCode == 200) {
      final json = jsonDecode(body);
      setState(() {
        products = json;
      });
      print('fetchProducts completed');
    } else {
      // Handle error and display a Snackbar
      showSnackBar(context, 'Failed to fetch products: ${response.statusCode}');
    }
  }

  void createProduct(Map<String, dynamic> productData) async {
    print('createProduct called');
    const url = 'https://fakestoreapi.com/products';
    final uri = Uri.parse(url);
    final response = await http.post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(productData),
    );
    if (response.statusCode == 200) {
      // Product created successfully, fetch the updated list of products
      fetchProducts();
      print('Product created successfully');
    } else {
      // Handle error and display a Snackbar
      showSnackBar(context, 'Failed to create product: ${response.statusCode}');
    }
  }

  void deleteProduct(int productId) async {
    print('deleteProduct called for product $productId');
    final url = 'https://fakestoreapi.com/products/$productId';
    final uri = Uri.parse(url);
    final response = await http.delete(uri);
    if (response.statusCode == 200) {
      // Product deleted successfully, fetch the updated list of products
      fetchProducts();
      print('Product deleted successfully');
    } else {
      // Handle error and display a Snackbar
      showSnackBar(context, 'Failed to delete product: ${response.statusCode}');
    }
  }
}
