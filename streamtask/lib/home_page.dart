import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String btcPrice = '';

  final btcChannel = IOWebSocketChannel.connect(
    'wss://stream.binance.com:9443/ws/btcusdt@trade');
    
    @override
    void initState(){
      super.initState();
      btcListen();
    }

    btcListen() {
    btcChannel.stream.listen((message) {
      Map getData = jsonDecode(message);
      setState(() {
        btcPrice = getData['p'];
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Web sockets'),
      ),
      body: Column(
              children:[
                 const Center(
                child:
                   CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: NetworkImage(
                      "https://s2.coinmarketcap.com/static/img/coins/200x200/1839.png",
                    ),
                  ),
                 ),
                 const SizedBox(height: 15,),
                  const Text("BNB/USDT"),
                  Text(btcPrice),
              ],
            ),
    );
  }
}
