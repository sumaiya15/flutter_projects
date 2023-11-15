import 'package:flutter/material.dart';
class ItemList extends StatefulWidget {
 const ItemList({super.key});
 
  @override
 State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  List<String> items = [];
  TextEditingController itemController = TextEditingController();

  // Function to add a new item to the list
  void addItem() {
    String newItem = itemController.text;
    if (newItem.isNotEmpty) {
      setState(() {
        items.add(newItem);
        itemController.clear();
      });
    }
  }

  // Function to delete an item from the list
  void deleteItem(int index) {
    setState(() {
      items.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children:[
        Padding(
          padding: const  EdgeInsets.all(16.0),
          child: Row(
            children:[
              Expanded(
                child: TextFormField(
                  controller: itemController,
                  decoration:const InputDecoration(
                    labelText: 'Enter Item',
                  ),
                ),
              ),
              IconButton(
                icon:const Icon(Icons.add),
                onPressed: addItem,
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(items[index]),
                trailing: IconButton(
                  icon:const Icon(Icons.delete),
                  onPressed: () => deleteItem(index),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
