import 'package:flutter/material.dart';

class Columns extends StatelessWidget {
  const Columns({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Columns Exercise')),
      body: Column(
       /* mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            color: Colors.red,
            width: 100,
            height: 50,
            child: Center(child: Text('Red', style: TextStyle(color: Colors.white))),
          ),
          Container(color: Colors.green, width: 100, height: 50),
          Container(color: Colors.blue, width: 100, height: 50),
        ],*/
        children: [
          Container(color: Colors.orange, width: 150, height: 50),
          SizedBox(height: 20),
          Container(color: Colors.purple, width: 150, height: 50),
          SizedBox(height: 40),
          Container(color: Colors.teal, width: 150, height: 50),
        ],
      ),
    );
  }
}