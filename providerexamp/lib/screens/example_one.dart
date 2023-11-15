import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providerexamp/provider/example_one_provider.dart';


class ExampleOneScreen extends StatefulWidget {
  const ExampleOneScreen({Key? key}) : super(key: key);

  @override
  State<ExampleOneScreen> createState() => _ExampleOneScreenState();
}

class _ExampleOneScreenState extends State<ExampleOneScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example One'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Consumer<ExampleOneProvider>(builder: (context, value, child){
              return Slider(
                  min: 0,
                  max: 1,
                  value: value.opacity, onChanged: (val){
                value.setCount(val);
              });
            }),

            Consumer<ExampleOneProvider>(builder: (context, value, child){
              return Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 100,
                      color: Colors.red.withOpacity(value.opacity),
                      child: const Center(child: Text('Container 1')),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 100,
                      color: Colors.green.withOpacity(value.opacity),
                      child: const Center(child: Text('Container 2')),
                    ),
                  ),

                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}