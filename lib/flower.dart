/*
const String _baseURL = 'https://bloomellashop.000webhostapp.com';

class Flower {
  final int id;
  final String name;
  final String description;
   int quantity;
  final double price;
  final String imageUrl;
  String category;
  bool isFavorite;

  Flower({
    required this.id,
    required this.name,
    required this.description,
    required this.quantity,
    required this.price,
    required this.imageUrl,
    required this.category,
    this.isFavorite = false,
  });

  // Add a copyWith method to create a new instance with updated properties
  Flower copyWith({
    int? id,
    String? name,
    String? description,
    int? quantity,
    double? price,
    String? imageUrl,
    String? category,
    bool? isFavorite,
  }) {
    return Flower(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  factory Flower.fromJson(Map<String, dynamic> json) {
    return Flower(
      id: int.parse(json['id'].toString()), // Parse as an integer
      name: json['name'],
      description: json['description'],
      quantity: int.parse(json['quantity'].toString()), // Parse as an integer
      price: double.parse(json['price'].toString()), // Parse as a double
      imageUrl: json['imageUrl'],
      category: json['category'],
      isFavorite: false,
    );
  }
}
*/
const String _baseURL = 'https://bloomellashop.000webhostapp.com';
class Flower {
  final int id;
  final String name;
  final String description;
  int quantity;
  final double price;
  final String imageUrl;
  String category;
  bool isFavorite;

  Flower({
    required this.id,
    required this.name,
    required this.description,
    required this.quantity,
    required this.price,
    required this.imageUrl,
    required this.category,
    this.isFavorite = false,
  });

  // Add a copyWith method to create a new instance with updated properties
  Flower copyWith({
    int? id,
    String? name,
    String? description,
    int? quantity,
    double? price,
    String? imageUrl,
    String? category,
    bool? isFavorite,
  }) {
    return Flower(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  factory Flower.fromJson(Map<String, dynamic> json) {
    return Flower(
      id: int.parse(json['id'].toString()), // Parse as an integer
      name: json['name'],
      description: json['description'],
      quantity: int.parse(json['quantity'].toString()), // Parse as an integer
      price: double.parse(json['price'].toString()), // Parse as a double
      imageUrl: json['imageUrl'],
      category: json['category'],
      isFavorite: false,
    );
  }
}