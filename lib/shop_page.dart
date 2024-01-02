// shop_page.dart

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../add/colors.dart';
import 'product_details_page.dart';
import 'flower.dart';
import 'cart_page.dart';
import 'favorites_page.dart';
import 'profile.dart';

const String _baseURL = 'https://bloomellashop.000webhostapp.com';

class ShopPage extends StatefulWidget {
  final String username;

  const ShopPage({Key? key, required this.username}) : super(key: key);

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  List<Flower> flowers = [];
  List<Flower> cartItems = [];
  List<Flower> favoriteItems = [];
  String searchQuery = '';
  String selectedCategory = 'All';

  @override
  void initState() {
    super.initState();
    // Load flowers data from PHP script
    fetchFlowers();
  }

  Future<void> fetchFlowers() async {
    try {
      final response = await http.get(Uri.parse('$_baseURL/Flower.php'));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        setState(() {
          flowers = List<Flower>.from(
              jsonData['flowers'].map((flower) => Flower.fromJson(flower)));
        });
      } else {
        print(
            'Failed to load flowers from API. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception during API call: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Flower> filteredFlowers = flowers
        .where((flower) =>
    (selectedCategory == 'All' || flower.category == selectedCategory) &&
        flower.name.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
         "Welcome, " +  widget.username + "!", // Use the provided username
          style: TextStyle(
            fontSize: 23,
            color: ksecondaryClr,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite, color: ksecondaryClr),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      FavoritesPage(favoriteItems: favoriteItems),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartPage(cartItems: cartItems),
                ),
              );
            },
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Profile(username: widget.username),
                ),
              );
            },
            icon: const Icon(Icons.account_circle_outlined),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // Search Section
            TextFormField(
              cursorColor: kprimaryClr,
              decoration: InputDecoration(
                filled: true,
                fillColor: klightGrayClr,
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: kprimaryClr, width: 2.0),
                  borderRadius: BorderRadius.circular(15),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                  const BorderSide(color: ksecondaryClr, width: 1.0),
                  borderRadius: BorderRadius.circular(15),
                ),
                hintText: 'Search Here...',
                prefixIcon: const Icon(
                  Icons.search,
                  color: kprimaryClr,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
            const SizedBox(
              height: 5,
            ),
            // Integrated ProductSection Design
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 0,
                  childAspectRatio: MediaQuery.of(context).size.width / 700,
                ),
                itemCount: filteredFlowers.length,
                itemBuilder: (context, index) {
                  final product = filteredFlowers[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailsPage(
                            flower: product,
                            cartItems: cartItems,
                            favoriteItems: favoriteItems,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: klightGrayClr,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                product.imageUrl,
                                height: 200,
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.contain,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  product.name,
                                  style: TextStyle(
                                    fontSize: 13.98,
                                    color: ksecondaryClr,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding:
                                      const EdgeInsets.only(right: 8.0),
                                      child: IconButton(
                                        icon: Icon(
                                          product.isFavorite
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color: product.isFavorite
                                              ? ksecondaryClr
                                              : null,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            product.isFavorite =
                                            !product.isFavorite;
                                            if (product.isFavorite) {
                                              favoriteItems.add(product);
                                            } else {
                                              favoriteItems.remove(product);
                                            }
                                          });
                                        },
                                      ),
                                    ),

                                  ],
                                ),
                              ],
                            ),
                            Text(
                              product.description,
                              maxLines: 2,
                              style: const TextStyle(
                                fontSize: 10,
                                color: kgrayClr,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              '\$${product.price.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: kgrayClr,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addToCart(Flower product) {
    setState(() {
      cartItems.add(product);
    });
  }
}

