import 'package:flutter/material.dart';
import '../models/product.dart';
import '../main_scaffold.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  ProductDetailScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      body: Column(
        children: [
          AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(product.name),
            elevation: 0,
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  product.image != null
                      ? Image.network(
                          product.image!,
                          width: double.infinity,
                          height: 260,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: double.infinity,
                              height: 260,
                              color: Colors.grey[300],
                              child: Icon(Icons.image_not_supported, size: 48),
                            );
                          },
                        )
                      : Container(
                          width: double.infinity,
                          height: 260,
                          color: Colors.grey[300],
                          child: Icon(Icons.shopping_bag, size: 48),
                        ),

                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(product.name,
                            style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold)),

                        SizedBox(height: 10),

                        Text(product.description),

                        SizedBox(height: 20),

                        Text(
                          '\$${product.price}',
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}