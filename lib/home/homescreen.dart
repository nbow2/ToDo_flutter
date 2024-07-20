import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Homescreen extends StatelessWidget {

  static const String routeName = 'home_screen';
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ToDo'),
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: Text('Emty'),
              color: Colors.red,
            ),
          ),
        ]
        ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label:'list',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'settings',
          ),
        ],
      ),

    );
  }
}
