import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

import 'login.dart';

const String _baseURL = 'https://bloomellashop.000webhostapp.com';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  bool _loading = false;

  void update(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
    setState(() {
      _loading = false;
    });
  }

  void _goToLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Login(),
      ),
    );
  }

  void _register() {
    if (_loading) return;

    if (_formKey.currentState!.validate()) {
      setState(() {
        _loading = true;
      });

      saveCustomer(
            (response) {
          update(response);

          // Adjust the navigation logic based on the registration result
          if (response == 'Registration successful') {
            _goToLogin();
          }
        },
        _controllerUsername.text,
        _controllerEmail.text,
        _controllerPassword.text,
      );
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
                  const SizedBox(height: 90),
                  Text(
                    'Register Page',
                    style: GoogleFonts.pacifico(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: _controllerUsername,
                          keyboardType: TextInputType.text,
                          style: GoogleFonts.montserratAlternates(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.pink, width: 3.0),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white70, width: 1.0),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            labelText: 'Username',
                            labelStyle: GoogleFonts.montserratAlternates(
                              fontSize: 16,
                              color: Colors.white70,
                            ),
                          ),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your username';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _controllerEmail,
                          style: GoogleFonts.montserratAlternates(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.pink, width: 3.0),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white70, width: 1.0),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            labelText: 'Email',
                            labelStyle: GoogleFonts.montserratAlternates(
                              fontSize: 16,
                              color: Colors.white70,
                            ),
                          ),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _controllerPassword,
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          style: GoogleFonts.montserratAlternates(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.pink, width: 3.0),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white70, width: 1.0),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            labelText: 'Password',
                            labelStyle: GoogleFonts.montserratAlternates(
                              fontSize: 16,
                              color: Colors.white70,
                            ),
                          ),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _register,
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
                            'Register',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const Login()),
                            );
                          },
                          style: TextButton.styleFrom(
                            textStyle: GoogleFonts.montserratAlternates(
                              fontSize: 18,
                            ),
                          ),
                          child: const Text(
                            "Already have an account? Sign in",
                            style: TextStyle(
                              color: Colors.white70,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Visibility(
                          visible: _loading,
                          child: const CircularProgressIndicator(),
                        ),
                      ],
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

void saveCustomer(
    Function(String text) update, String username, String email, String password) async {
  try {
    final response = await http.post(
      Uri.parse('$_baseURL/register.php'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'email': email,
        'password': password,
        'key': 'your_key',
      }),
    ).timeout(const Duration(seconds: 5));

    if (response.statusCode == 200) {
      update(response.body);
    } else {
      update('Registration failed. Please try again.');
    }
  } catch (e) {
    update('Error during registration: $e');
  }
}
