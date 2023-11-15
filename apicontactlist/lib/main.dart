import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FilteredList(),
    );
  }
}

class FilteredList extends StatefulWidget {
  @override
  _FilteredListState createState() => _FilteredListState();
}

class _FilteredListState extends State<FilteredList> {
  List<String> items = ['Item 1', 'Item 3', 'Item 2', 'Item 5', 'Item 4'];
  String selectedOrder = 'Ascending';

  void toggleOrder(String? newOrder) {
    if (newOrder != null) {
      setState(() {
        selectedOrder = newOrder;
        if (selectedOrder == 'Ascending') {
          items.sort();
        } else {
          items.sort((a, b) => b.compareTo(a));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filter List'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          DropdownButton<String>(
            value: selectedOrder,
            items: ['Ascending', 'Descending'].map((String order) {
              return DropdownMenuItem<String>(
                value: order,
                child: Text(order),
              );
            }).toList(),
            onChanged: toggleOrder,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(items[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
