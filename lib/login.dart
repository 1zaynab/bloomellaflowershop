import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'shop_page.dart';
import 'profile.dart';
import 'registration.dart';

const String _baseURL = 'https://bloomellashop.000webhostapp.com';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void _goToRegistration() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Registration(),
      ),
    );
  }

  void _navigateToFlowerShopPage(String username) async {
    await Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ShopPage(username: username),
      ),
    );
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      try {
        setState(() {});

        final response = await http.post(
          Uri.parse('$_baseURL/login.php'),
          body: {
            'username': usernameController.text,
            'password': passwordController.text,
          },
        );

        print('Raw Response Body: ${response.body}');

        if (response.statusCode == 200) {
          final Map<String, dynamic> result = json.decode(response.body);

          if (result['status'] == 'success') {
            _navigateToFlowerShopPage(usernameController.text);
          } else {
            print('Login failed: ${result['message']}');
          }
        } else {
          print('Server error: ${response.statusCode}');
        }
      } catch (e) {
        print('Error during login: $e');
      } finally {
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/background.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(height: 100),
                  Text(
                    "Bloomella Shop",
                    style: GoogleFonts.pacifico(
                      fontSize: 45,
                      color: Colors.white,
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          const SizedBox(height: 90),
                          Text(
                            'Login Page',
                            style: GoogleFonts.pacifico(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: usernameController,
                            style: GoogleFonts.montserratAlternates(
                              fontSize: 16,
                              color: Colors.white,

                            ),
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.pink, width: 3.0),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              labelText: 'Username',
                              labelStyle: GoogleFonts.montserratAlternates(
                                fontSize: 16,
                                color: Colors.white70,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your username';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: passwordController,

                            style: GoogleFonts.montserratAlternates(
                              fontSize: 16,
                              color: Colors.white,

                            ),
                            obscureText: true,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.pink, width: 3.0),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              labelText: 'Password',
                              labelStyle: GoogleFonts.montserratAlternates(
                                fontSize: 16,
                                color: Colors.white70,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: _login,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.pink,
                              textStyle: GoogleFonts.montserratAlternates(
                                fontSize: 16,
                              ),
                              padding: const EdgeInsets.all(15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: const Text(
                              'Sign in',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextButton(
                            onPressed: _goToRegistration,
                            style: TextButton.styleFrom(
                              textStyle: GoogleFonts.montserratAlternates(
                                fontSize: 18,
                              ),
                            ),
                            child: const Text(
                              "Don't have an account? Register",
                              style: TextStyle(
                                color: Colors.white70,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

