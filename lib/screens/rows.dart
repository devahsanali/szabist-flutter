import 'package:flutter/material.dart';

class Rows extends StatelessWidget {
  const Rows({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Rows Exercise')),
      body: Row(
          /*mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(color: Colors.red, width: 50, height: 50),
            Container(color: Colors.green, width: 70, height: 70),
            Container(color: Colors.blue, width: 50, height: 50),
          ],*/

         /*children: [
            Container(color: Colors.orange, width: 60, height: 60),
            SizedBox(width: 20),
            Container(color: Colors.purple, width: 60, height: 60),
            SizedBox(width: 40),
            Container(color: Colors.teal, width: 60, height: 60),
          ],*/


        children: [
          Expanded(
            flex: 2,
            child: Container(color: Colors.blue),
          ),
          Expanded(
            flex: 1,
            child: Container(color: Colors.red),
          ),
          Stack(
            children: [
              Container(color: Colors.yellow, width: 50, height: 50),
              Positioned(
                top: 10,
                left: 10,
                child: Container(color: Colors.purple, width: 25, height: 25),
              ),
              Positioned(
                top: 30,
                left: 20,
                child: Container(color: Colors.green, width: 50, height: 50),
              ),
            ],
          ),
          Stack(
            children: [
              Container(color: Colors.orange, width: 100, height: 100),

              Positioned(
                top: 10,
                left: 10,
                child: Row(
                  children: [
                    Container(color: Colors.purple, width: 25, height: 25),
                    SizedBox(width: 5),
                    Container(color: Colors.white, width: 25, height: 25),
                  ],
                ),
              ),

              Positioned(
                top: 50,
                left: 20,
                child: Column(
                  children: [
                    Container(color: Colors.green, width: 20, height: 20),
                    SizedBox(height: 5),
                    Container(color: Colors.blue, width: 20, height: 20),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}