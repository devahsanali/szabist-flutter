import 'package:f2/main_scaffold.dart';
import 'package:f2/screens/cart_screen.dart';
import 'package:flutter/material.dart';
import 'colors/ColorStateContainer.dart';
import 'screens/columns.dart';
import 'screens/rows.dart';
import 'screens/simple_form.dart';
import 'screens/complete_form.dart';
import 'screens/profile_form.dart';
import 'screens/profile_view.dart';
import 'colors/color_chooser.dart';
import 'colors/color_chooser_inherited.dart';
import 'package:provider/provider.dart';
import 'provider/cart_model.dart';
import 'screens/products_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'provider/auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final authProvider = AuthProvider();
  await authProvider.loadToken();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartModel()),
        ChangeNotifierProvider.value(value: authProvider),
      ],
      child: ColorStateContainer(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    return MaterialApp(
      title: 'Flutter Navigation Examples',
      initialRoute: auth.isLoggedIn ? '/' : '/login',
      routes: {
        '/': (context) => HomeScreen(),
        '/column': (context) => Columns(),
        '/row': (context) => Rows(),
        '/simple_form': (context) => SimpleForm(),
        '/complete_form': (context) => CompleteForm(),
        '/profile_form': (context) => ProfileForm(),
        //'/profile_view': (context) => ProfileView(name: '', date: ''),
        '/profile_view': (context) => ProfileView(),
        '/color_demo': (context) => ColorChooser(),
        '/color_demo_inherited': (context) => ColorChooserInherited(),
        '/cart': (context) => CartScreen(),
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/products': (context) => ProductsScreen(),
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