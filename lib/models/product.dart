import '../app_config.dart';

class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String? image;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: double.parse(json['price'].toString()),
      image: AppConfig.resolveImageUrl(json['image']?.toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'price': price,
      if (image != null) 'image': image,
    };
  }
}