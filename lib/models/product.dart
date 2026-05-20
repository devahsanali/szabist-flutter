class Product {
  final String id;
  final String name;
  final String description;
  final double price;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: double.parse(json['price'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'price': price,
    };
  }
}