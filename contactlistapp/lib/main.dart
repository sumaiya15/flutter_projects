import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(
  BlocProvider(
    create: (context) => ContactsBloc(ContactRepository()), // Create ContactsBloc here
    child: const MyApp(),
  ),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Contacts'),
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Contact 1'),
                Tab(text: 'Contact 2'),
                Tab(text: 'Contact 3'),
                Tab(text: 'Contact 4'),
                Tab(text: 'Contact 5'),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              WatchlistPage(contactId: 1),
              WatchlistPage(contactId: 2),
              WatchlistPage(contactId: 3),
              WatchlistPage(contactId: 4),
              WatchlistPage(contactId: 5),
            ],
          ),
        ),
      ),
    );
  }
}

class WatchlistPage extends StatefulWidget {
  final int contactId;

  const WatchlistPage({required this.contactId, Key? key}) : super(key: key);

  @override
  State<WatchlistPage> createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> {
  @override
  void initState() {
    super.initState();
    // Dispatch the FetchContactsEvent when the page is initialized
    context.read<ContactsBloc>().add(FetchContactsEvent(widget.contactId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactsBloc, ContactState>(
      builder: (context, state) {
        if (state is ContactInitial) {
          return Center(child: CircularProgressIndicator()); // Loading indicator
        } else if (state is ContactLoaded) {
          return ContactList(contacts: state.contacts);
        } else if (state is ContactError) {
          return Text('Error: ${state.error}');
        } else {
          return Text('Unknown state');
        }
      },
    );
  }
}

class ContactList extends StatelessWidget {
  final List<Contact> contacts;

  ContactList({required this.contacts});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: contacts.length,
      itemBuilder: (context, index) {
        final contact = contacts[index];
        return Card(
          child: ListTile(
            trailing: const CircleAvatar(
              //backgroundImage: NetworkImage(contact.photoUrl),
            ),
            title: Text(contact.name),
            subtitle: Text(contact.phoneNumber),
          ),
        );
      },
    );
  }
}

class Contact {
  final String name;
  final String phoneNumber;

  Contact({
    required this.name,
    required this.phoneNumber,
  });
}

// Bloc code
abstract class ContactEvent {}

class FetchContactsEvent extends ContactEvent {
  final int contactId;
  FetchContactsEvent(this.contactId);
}

abstract class ContactState {}

class ContactInitial extends ContactState {}

class ContactLoading extends ContactState {}

class ContactLoaded extends ContactState {
  final List<Contact> contacts;
  ContactLoaded(this.contacts);
}

class ContactError extends ContactState {
  final String error;
  ContactError(this.error);
}

class ContactsBloc extends Bloc<ContactEvent, ContactState> {
  final ContactRepository _contactRepository;

  ContactsBloc(this._contactRepository) : super(ContactInitial());

  Stream<ContactState> mapEventToState(ContactEvent event) async* {
    if (event is FetchContactsEvent) {
      yield ContactLoading();

      try {
        final contacts = await _contactRepository.getContacts(event.contactId);
        yield ContactLoaded(contacts);
      } catch (e) {
        yield ContactError('Failed to load contacts');
      }
    }
  }
}

 

class ContactRepository {
  Future<List<Contact>> getContacts(int contactId) async {
    final response = await http.get(Uri.parse('http://5e53a76a31b9970014cf7c8c.mockapi.io/msf/getContacts?id=$contactId'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      final List<Contact> parsedContacts = (jsonData as List).map((contactJson) {
        return Contact(
          name: contactJson['name'],
          phoneNumber: contactJson['Contacts'],
        );
      }).toList();

      return parsedContacts;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
