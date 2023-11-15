import 'package:flutter/material.dart';
import 'package:watchlist/Screens/watchlist_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Contacts'),
            titleTextStyle:const TextStyle(fontSize: 28,fontWeight:FontWeight.bold ,color:Colors.black),
            backgroundColor: Colors.white,
            bottom: const TabBar(
              labelPadding: EdgeInsets.symmetric(horizontal: 8.0),
              tabs: [
                Tab(text: 'Contact 1'),
                Tab(text: 'Contact 2'),
                Tab(text: 'Contact 3'),
                Tab(text: 'Contact 4'),
                Tab(text: 'Contact 5'),
              ],
              labelColor: Colors.black,
              labelStyle: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          body: const TabBarView(
            children: [
              WatchlistPage(contactStartId: 1, contactEndId: 20),
              WatchlistPage(contactStartId: 21, contactEndId: 40),
              WatchlistPage(contactStartId: 41, contactEndId: 60),
              WatchlistPage(contactStartId: 61, contactEndId: 80),
              WatchlistPage(contactStartId: 81, contactEndId: 100),
            ],
          ),
        ),
      ),
    );
  }
}
