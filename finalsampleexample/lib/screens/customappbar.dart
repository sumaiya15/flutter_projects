import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('January 2023', style: TextStyle(fontSize: 25)),
          Row(
            children: [
              IconButton(
                icon:const  Icon(Icons.arrow_back_ios_sharp),
                onPressed: () {
                },
              ),
              Card(
                elevation: 2,
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child:const Text(
                    'Today',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward_ios_outlined),
                onPressed: () {
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
