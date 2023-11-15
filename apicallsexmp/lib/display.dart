import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';

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
            leading: SizedBox(
              width: 80,
              height: 80,
              child: Image.network(
                imageUrl,
                fit: BoxFit.contain,
              ),
            ),
            title: Text(name),
            subtitle: Text(category),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchProducts,
        child: const Icon(Icons.refresh),
      ),
    );
  }

  void fetchProducts() async {
    print('fetchProducts called');
    const url = 'https://fakestoreapi.com/products';
    final uri = Uri.parse(url);

    try {
      final httpClient = HttpClient();
      final request = await httpClient.getUrl(uri);
      final response = await request.close();

      if (response.statusCode == HttpStatus.ok) {
        final responseBody = await response.transform(utf8.decoder).join();
        final json = jsonDecode(responseBody);

        setState(() {
          products = json;
        });

        print('fetchProducts completed');
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
