import 'package:flutter/material.dart';
import 'flower.dart';

class ProductDetailsPage extends StatefulWidget {
  final Flower flower;
  final List<Flower> cartItems;
  final List<Flower> favoriteItems;

  const ProductDetailsPage({
    Key? key,
    required this.flower,
    required this.cartItems,
    required this.favoriteItems,
  }) : super(key: key);

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  TextEditingController quantityController = TextEditingController(text: '1');

  @override
  void initState() {
    super.initState();
    quantityController = TextEditingController(text: '1');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(widget.flower.name),
              background: Image.asset(
                widget.flower.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Icon(
                              widget.flower.isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: widget.flower.isFavorite
                                  ? Colors.pink[400]
                                  : null,
                            ),
                            onPressed: () {
                              setState(() {
                                widget.flower.isFavorite =
                                !widget.flower.isFavorite;
                                if (widget.flower.isFavorite) {
                                  widget.favoriteItems.add(widget.flower);
                                } else {
                                  widget.favoriteItems.remove(widget.flower);
                                }
                              });
                            },
                          ),
                          SizedBox(
                            width: 120,
                            child: ElevatedButton(
                              onPressed: () {
                                int quantity =
                                int.parse(quantityController.text);

                                // Create a copy of the Flower object with the updated quantity
                                Flower productToAdd = widget.flower.copyWith(
                                  quantity: quantity,
                                );

                                // Add the product to 'widget.cartItems'
                                widget.cartItems.add(productToAdd);

                                // Optionally, you can show a snackbar or navigate to the cart page
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        '${widget.flower.name} (Quantity: $quantity) added to the cart'),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.pink,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text('Add to Cart',style: TextStyle(color: Colors.white70),),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.flower.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '\$${(widget.flower.price * int.parse(quantityController.text)).toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Category: ${widget.flower.category}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        widget.flower.description,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                      Row(
                        children: [
                          SizedBox(

                            child: OutlinedButton(
                              onPressed: () {
                                int quantity =
                                int.parse(quantityController.text);
                                if (quantity > 1) {
                                  quantityController.text =
                                      (quantity - 1).toString();
                                }
                                updateTotalPrice();
                              },
                              child: Icon(Icons.remove),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: SizedBox(
                              width: 15,
                              child: TextFormField(
                                controller: quantityController,
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  updateTotalPrice();
                                },
                              ),
                            ),
                          ),
                          SizedBox(

                            child: OutlinedButton(
                              onPressed: () {
                                int quantity =
                                int.parse(quantityController.text);
                                quantityController.text =
                                    (quantity + 1).toString();
                                updateTotalPrice();
                              },
                              child: Icon(Icons.add),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void updateTotalPrice() {
    setState(() {});
  }

  @override
  void dispose() {
    quantityController.dispose();
    super.dispose();
  }
}
