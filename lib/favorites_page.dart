
import 'package:flutter/material.dart';
import 'flower.dart';
const String _baseURL = 'https://bloomellashop.000webhostapp.com';

class FavoritesPage extends StatelessWidget {
  final List<Flower> favoriteItems;

  const FavoritesPage({Key? key, required this.favoriteItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text('Favorites'),
      ),
      body: ListView.builder(
        itemCount: favoriteItems.length,
        itemBuilder: (context, index) {
          final product = favoriteItems[index];
          return ListTile(
            title: Text(product.name),
            subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
          );
        },
      ),
    );
  }
}