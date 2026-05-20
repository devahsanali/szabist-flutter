import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/cart_model.dart';

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
      appBar: AppBar(title: Text("Flutter App"),
      actions: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/cart');
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              Icon(Icons.shopping_cart, size: 30),
              Positioned(
                right: 0,
                top: 5,
                child: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: Text(
                    '${context.watch<CartModel>().count}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 16),
      ],
    ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(child: Text("Menu")),
            ListTile(title: Text("Home"), onTap: () => Navigator.pushNamed(context, '/')),
            ListTile(title: Text("Rows"), onTap: () => Navigator.pushNamed(context, '/row')),
            ListTile(title: Text("Columns"), onTap: () => Navigator.pushNamed(context, '/column')),
            ListTile(title: Text("Profile Form"), onTap: () => Navigator.pushNamed(context, '/profile_form')),
            ListTile(title: Text("Color Demo"), onTap: () => Navigator.pushNamed(context, '/color_demo')),
            ListTile(title: Text("Color InheritedWidget"), onTap: () => Navigator.pushNamed(context, '/color_demo_inherited')),
            ListTile(title: Text("Cart (Provider Demo)"), onTap: () => Navigator.pushNamed(context, '/cart')),
            ListTile(title: Text("Products"), onTap: () => Navigator.pushNamed(context, '/products')),
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
          BottomNavigationBarItem(icon: Icon(Icons.view_column), label: 'Columns'),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
            //backgroundColor: Colors.purple,
          ),
        ],
      ),
    );
  }
}