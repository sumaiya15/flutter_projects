import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providerexamp/provider/favourite_providder.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourite Index'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
              itemCount: 100,
              itemBuilder: (context, index){
                return Card(
                  child: Consumer<FavouriteProvider>(builder: (context, value, child){
                    return ListTile(
                      onTap: (){
                        if(value.selectedValue.contains(index)){
                          value.removeValue(index);
                        }else {
                          value.addValue(index);
                        }
                      },
                      title: Text('item ${index + 1}'),
                      trailing: Icon( value.selectedValue.contains(index) ? Icons.favorite: Icons.favorite_border_outlined),
                    );
                  }),
                );
          }))
        ],
      ),
    );
  }
}