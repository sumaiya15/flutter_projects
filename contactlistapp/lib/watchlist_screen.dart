import 'dart:convert';

import 'package:contactlistapp/contact_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class WatchlistPage extends StatefulWidget {
  final int contactId;

  const WatchlistPage({super.key, required this.contactId,});

  @override
  State<WatchlistPage> createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> {
  List<Contact> contacts = [];

  @override
  void initState() {
    super.initState();
    fetchData(widget.contactId);
  }

  Future<void> fetchData(int contactId) async {
    final response = await http.get(Uri.parse('http://5e53a76a31b9970014cf7c8c.mockapi.io/msf/getContacts?id=$contactId'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      final List<Contact> parsedContacts = (jsonData as List).map((contactJson) {
        return Contact(
          name: contactJson['name'],
          phoneNumber: contactJson['Contacts'],
        );
      }).toList();

      setState(() {
        contacts = parsedContacts;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: contacts.length,
      itemBuilder: (context, index) {
        final contact = contacts[index];
        return Card(
          child: ListTile(
            trailing:const CircleAvatar(
            ),
            title: Text(contact.name),
            subtitle: Text(contact.phoneNumber),
          ),
        );
      },
    );
  }
}

