import 'package:flutter/material.dart';

class MainScaffold extends StatefulWidget {
  final Widget body;
  final int currentIndex;

  MainScaffold({required this.body, this.currentIndex = 0});

  @override
  _MainScaffoldState createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.currentIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/');
        break;
      case 1:
        Navigator.pushNamed(context, '/row');
        break;
      case 2:
        Navigator.pushNamed(context, '/column');
        break;
      case 3:
        Navigator.pushNamed(context, '/profile_form');
        break;
    }
  }

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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            //backgroundColor: Colors.yellow,
          ),
          BottomNavigationBarItem(icon: Icon(Icons.view_week), label: 'Rows'),
          BottomNavigationBarItem(icon: Icon(Icons.view_column), label: 'Columns')
        ],
      ),
    );
  }
}