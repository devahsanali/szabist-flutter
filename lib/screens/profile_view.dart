import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  /*final String name;
  final String date;*/

  //ProfileView({required this.name, required this.date});
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    String name = args['name'];
    String date = args['date'];

    return Scaffold(
      appBar: AppBar(title: Text("Profile View")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Name: $name"),
          Text("Date: $date"),

          SizedBox(height: 20),

          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, "Profile Saved Successfully!");
            },
            child: Text("Back"),
          ),
        ],
      ),
    );
  }
}