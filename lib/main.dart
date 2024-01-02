import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';
import 'shop_page.dart';

const String _baseURL = 'https://bloomellashop.000webhostapp.com';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isLoggedIn ? const MyApp() : const Login(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Shop App',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const ShopPage(username: ''),
    );
  }
}
