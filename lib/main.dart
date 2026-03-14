import 'package:flutter/material.dart';
import 'screens/columns.dart';
import 'screens/rows.dart';
import 'screens/simple_form.dart';
import 'screens/complete_form.dart';

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
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter Examples Home')),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/row'),
              child: Text('Rows Exercises'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/column'),
              child: Text('Columns Exercises'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/simple_form'),
              child: Text('Simple Form Example'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/complete_form'),
              child: Text('Complete Form Example'),
            ),
          ],
        ),
      ),
    );
  }
}