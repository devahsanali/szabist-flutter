import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/cart_model.dart';
import 'provider/auth_provider.dart';

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

  void protectedNavigation(String route) {
    Navigator.pop(context);

    final auth = context.read<AuthProvider>();

    if (auth.isLoggedIn) {
      Navigator.pushNamed(context, route);
    } else {
      Navigator.pushNamed(context, '/login');
    }
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
        IconButton(
          icon: Icon(Icons.logout),
          onPressed: () async {
            await context.read<AuthProvider>().logout();

            Navigator.pushNamedAndRemoveUntil(
              context,
              '/login',
                  (route) => false,
            );
          },
        ),
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
            ListTile(title: Text("Home"), onTap: () => protectedNavigation('/')),
            ListTile(title: Text("Rows"), onTap: () => protectedNavigation('/row')),
            ListTile(title: Text("Columns"), onTap: () => protectedNavigation('/column')),
            ListTile(title: Text("Profile Form"), onTap: () => protectedNavigation('/profile_form')),
            ListTile(title: Text("Color Demo"), onTap: () => protectedNavigation('/color_demo')),
            ListTile(title: Text("Color InheritedWidget"), onTap: () => protectedNavigation('/color_demo_inherited')),
            ListTile(title: Text("Cart (Provider Demo)"), onTap: () => protectedNavigation('/cart')),
            ListTile(title: Text("Products"), onTap: () => protectedNavigation('/products')),
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