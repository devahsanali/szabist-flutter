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
          Image.network("https://placehold.co/150x50.png"),

          Image.network(
            "https://placehold.co/150x50.png",
            width: 150,
            height: 50,
            errorBuilder: (context, error, stackTrace) {
              return Icon(Icons.error, size: 50);
            },
          ),

          Image.asset(
            'assets/images/profile.png',
            width: 100,
            height: 100,
          ),

          SizedBox(height: 20),
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