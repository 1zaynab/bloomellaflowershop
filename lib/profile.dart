import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'shop_page.dart';

const String _baseURL = 'https://bloomellashop.000webhostapp.com';

class Profile extends StatefulWidget {
  final String username;

  const Profile({Key? key, required this.username}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Future<void> _logout() async {
    try {
      final response = await http.post(
        Uri.parse('$_baseURL/logout.php'),
      );

      print('Logout Response Body: ${response.body}');

      if (response.statusCode == 200) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Login()),
        );
      } else {
        print('Logout failed: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during logout: $e');
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  Text(
                    'Bloomella Shop',
                    style: GoogleFonts.pacifico(
                      fontSize: 50,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'Your Profile',
                    style: GoogleFonts.pacifico(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Welcome, ${widget.username}!',
                          style: GoogleFonts.pacifico(
                            fontSize: 35,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Include additional profile information as needed
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Center(
                    // Wrap the Row with Center
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment
                          .center, // Align buttons to the center
                      children: [
                        ElevatedButton(
                          onPressed: _logout,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            textStyle: const TextStyle(fontSize: 25),
                            padding: const EdgeInsets.all(15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: Text(
                            'Logout',
                            style: GoogleFonts.pacifico(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(
                            width: 20), // Add spacing between buttons
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ShopPage(username: '')),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            textStyle: const TextStyle(fontSize: 25),
                            padding: const EdgeInsets.all(15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: Text(
                            'Shop',
                            style: GoogleFonts.pacifico(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
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
