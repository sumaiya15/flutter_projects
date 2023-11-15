import 'package:contactlistapp/watchlist_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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

