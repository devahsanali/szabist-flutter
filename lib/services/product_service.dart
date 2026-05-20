import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ProductService {
  static const String baseUrl =
      "http://10.0.2.2:3000/products";

  // FETCH PRODUCTS
  Future<List<Product>> fetchProducts() async {
    try {
      final response = await http.get(
        Uri.parse(baseUrl),
      );

      print("FETCH STATUS: ${response.statusCode}");
      print("FETCH BODY: ${response.body}");

      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);

        return data
            .map((e) => Product.fromJson(e))
            .toList();
      } else {
        throw Exception(
          "Failed to load products",
        );
      }
    } catch (e) {
      throw Exception(
        "Fetch Error: $e",
      );
    }
  }

  // ADD PRODUCT
  Future<void> addProduct(Product product) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(product.toJson()),
      );

      print("ADD STATUS: ${response.statusCode}");
      print("ADD BODY: ${response.body}");

      if (response.statusCode != 200 &&
          response.statusCode != 201) {
        throw Exception(
          "Failed to add product: ${response.body}",
        );
      }
    } catch (e) {
      throw Exception(
        "Add Error: $e",
      );
    }
  }

  // UPDATE PRODUCT
  Future<void> updateProduct(
      String id,
      Product product,
      ) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/$id'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(product.toJson()),
      );

      print("UPDATE STATUS: ${response.statusCode}");
      print("UPDATE BODY: ${response.body}");

      if (response.statusCode != 200) {
        throw Exception(
          "Failed to update product: ${response.body}",
        );
      }
    } catch (e) {
      throw Exception(
        "Update Error: $e",
      );
    }
  }

  // DELETE PRODUCT
  Future<void> deleteProduct(String id) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/$id'),
      );

      print("DELETE STATUS: ${response.statusCode}");
      print("DELETE BODY: ${response.body}");

      if (response.statusCode != 200) {
        throw Exception(
          "Failed to delete product: ${response.body}",
        );
      }
    } catch (e) {
      throw Exception(
        "Delete Error: $e",
      );
    }
  }
}