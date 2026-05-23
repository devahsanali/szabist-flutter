import 'dart:convert';
import '../models/product.dart';
import 'api_client.dart';

class ProductService {
  final ApiClient api;

  ProductService(this.api);

  // FETCH PRODUCTS
  Future<List<Product>> fetchProducts() async {
    final response = await api.get("/products");

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => Product.fromJson(e)).toList();
    }

    throw Exception("Failed to load products");
  }

  // ADD PRODUCT
  Future<void> addProduct(Product product) async {
    final response = await api.post(
      "/products",
      product.toJson(),
    );

    if (response.statusCode != 200 &&
        response.statusCode != 201) {
      throw Exception("Failed to add product");
    }
  }

  // UPDATE PRODUCT
  Future<void> updateProduct(String id, Product product) async {
    final response = await api.put(
      "/products/$id",
      product.toJson(),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to update product");
    }
  }

  // DELETE PRODUCT
  Future<void> deleteProduct(String id) async {
    final response = await api.delete("/products/$id");

    if (response.statusCode != 200) {
      throw Exception("Failed to delete product");
    }
  }
}