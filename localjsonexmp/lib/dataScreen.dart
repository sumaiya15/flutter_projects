import  'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import the services.dart package for asset loading.
import 'dart:convert';

class JsonDataScreen extends StatefulWidget {
  const JsonDataScreen({super.key});

  @override
  State<JsonDataScreen> createState() => _JsonDataScreenState();
}

class _JsonDataScreenState extends State<JsonDataScreen> {
  List<dynamic> jsonData = []; // List to store parsed JSON data.

  @override
  void initState() {
    super.initState();
    loadJsonData();
  }

  Future<void> loadJsonData() async {
    // Load and parse the JSON file from the assets.
    final String jsonContent = await rootBundle.loadString('assets/data.json');
    final List<dynamic> parsedJson = json.decode(jsonContent);

    setState(() {
      jsonData = parsedJson;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Local JSON Example'),
      ),
      body: jsonData.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: jsonData.length,
              itemBuilder: (context, index) {
                final item = jsonData[index];
                return ListTile(
                  title: Text(item['name']),
                  subtitle: Text(item['description']),
                );
              },
            ),
    );
  }
}
