class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final int quantity;
  final String image;
  final String category;
  final int? nbSales; // Make nbSales nullable

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
    required this.image,
    required this.category,
    this.nbSales, // Remove required keyword
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: json['price']?.toDouble() ?? 0.0,
      quantity: json['quantity'] ?? 0,
      image: json['image'] ?? '',
      category: json['category'] ?? '',
      nbSales: json['nbSales'] ?? null, // Assign null if missing
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'description': description,
      'price': price,
      'quantity': quantity,
      'image': image,
      'category': category,
      if (nbSales != null) 'nbSales': nbSales, // Include only if not null
    };
  }
}

