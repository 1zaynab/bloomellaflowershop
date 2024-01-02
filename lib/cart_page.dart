// cart_page.dart

import 'package:flutter/material.dart';
import 'flower.dart';

class CartPage extends StatefulWidget {
  final List<Flower> cartItems;

  const CartPage({Key? key, required this.cartItems}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    double totalPrice = widget.cartItems.fold(
        0, (sum, product) => sum + (product.price * product.quantity));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text('Shopping Cart'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.cartItems.length,
              itemBuilder: (context, index) {
                final product = widget.cartItems[index];
                return Dismissible(
                  key: Key(product.name),
                  onDismissed: (direction) {
                    setState(() {
                      widget.cartItems.removeAt(index);
                    });
                  },
                  background: Container(
                    color: Colors.pink,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white38,
                    ),
                  ),
                  child: ListTile(
                    title: Text(product.name),
                    subtitle: Text(
                        '\$${(product.price * product.quantity).toStringAsFixed(2)}'),
                    trailing: Text('Qty: ${product.quantity}'),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total: \$${totalPrice.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Perform the order confirmation or navigate to the checkout page
                    // For now, we'll display a simple confirmation dialog
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Order Confirmation'),
                          content: const Text('Your order has been placed.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Place Order',
                  style: TextStyle(color: Colors.white70)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
