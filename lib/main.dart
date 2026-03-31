import 'package:f2/main_scaffold.dart';
import 'package:flutter/material.dart';
import 'screens/columns.dart';
import 'screens/rows.dart';
import 'screens/simple_form.dart';
import 'screens/complete_form.dart';
import 'screens/profile_form.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Navigation Examples',
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/column': (context) => Columns(),
        '/row': (context) => Rows(),
        '/simple_form': (context) => SimpleForm(),
        '/complete_form': (context) => CompleteForm(),
        '/profile_form': (context) => ProfileForm()
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/complete_form');
          },
          child: Text(
            "Welcome to Home Screen\n(Tap to go to Complete Form Screen)",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ),
    );
  }
}