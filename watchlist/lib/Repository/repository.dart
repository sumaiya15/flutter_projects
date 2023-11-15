import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:watchlist/Model/model.dart';

class Repository {
  static Future<List<Contact>> fetchContacts(contactStartId,contactEndId) async {
    final response = await http.get(
      Uri.parse('http://5e53a76a31b9970014cf7c8c.mockapi.io/msf/getContacts'),
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<Contact> parsedContacts = (jsonData as List).map((contactJson) {
        final id = int.parse(contactJson['id']);
        if (id >= contactStartId && id <= contactEndId) {
          return Contact(
            name: contactJson['name'],
            phoneNumber: contactJson['Contacts'],
          );
        } else {
          return Contact(name: '', phoneNumber: '');
        }
      }).where((contact) => contact.name.isNotEmpty && contact.phoneNumber.isNotEmpty).toList();
      return parsedContacts;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
