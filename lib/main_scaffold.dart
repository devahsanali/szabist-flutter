import 'package:flutter/material.dart';

class MainScaffold extends StatefulWidget {
  final Widget body;

  MainScaffold({required this.body});

  @override
  _MainScaffoldState createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flutter App")),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(child: Text("Menu")),
            ListTile(title: Text("Home"), onTap: () => Navigator.pushNamed(context, '/')),
            ListTile(title: Text("Rows"), onTap: () => Navigator.pushNamed(context, '/row')),
            ListTile(title: Text("Columns"), onTap: () => Navigator.pushNamed(context, '/column')),
            ListTile(title: Text("Profile Form"), onTap: () => Navigator.pushNamed(context, '/profile_form')),
          ],
        ),
      ),
      body: widget.body,
    );
  }
}