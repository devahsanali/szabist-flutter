import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../provider/auth_provider.dart';
import '../services/api_client.dart';
import '../services/product_service.dart';
import 'product_form_screen.dart';
import 'product_detail_screen.dart';
import '../main_scaffold.dart';

class ProductsScreen extends StatefulWidget {
  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  late ProductService service;

  late Future<List<Product>> futureProducts;

  @override
  void initState() {
    super.initState();
    final auth = Provider.of<AuthProvider>(context, listen: false);
    final apiClient = ApiClient(auth);
    service = ProductService(apiClient);
    loadProducts();
  }

  void loadProducts() {
    futureProducts = service.fetchProducts();
  }

  void refresh() {
    setState(() {
      loadProducts();
    });
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: 10),

              ElevatedButton.icon(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProductFormScreen(),
                    ),
                  );

                  if (result == true) {
                    refresh();

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Product added successfully'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                },
                icon: Icon(Icons.add),
                label: Text("Add Product"),
              ),

              Expanded(
                child: FutureBuilder<List<Product>>(
                  future: futureProducts,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          snapshot.error.toString(),
                        ),
                      );
                    }

                    if (!snapshot.hasData ||
                        snapshot.data == null ||
                        snapshot.data!.isEmpty) {
                      return Center(
                        child: Text("No products found"),
                      );
                    }

                    final products = snapshot.data!;

                      return ListView.builder(
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                        final product = products[index];

                        return Card(
                          margin: EdgeInsets.all(10),
                          elevation: 3,
                          child: ListTile(
                            leading: ClipRRect(
                              borderRadius:
                              BorderRadius.circular(8),
                              child: Image.network(
                                'https://picsum.photos/200',
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                            ),

                            title: Text(product.name),

                            subtitle: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(product.description),

                                SizedBox(height: 5),

                                Text(
                                  '\$${product.price}',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),

                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      ProductDetailScreen(
                                        product: product,
                                      ),
                                ),
                              );
                            },

                            trailing: Row(
                              mainAxisSize:
                              MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.blue,
                                  ),
                                  onPressed: () async {
                                    final result =
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            ProductFormScreen(
                                              product: product,
                                            ),
                                      ),
                                    );

                                    if (result == true) {
                                      refresh();

                                      ScaffoldMessenger.of(
                                          context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Product updated successfully',
                                          ),
                                          backgroundColor:
                                          Colors.green,
                                        ),
                                      );
                                    }
                                  },
                                ),

                                IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () async {
                                    final confirm =
                                    await showDialog(
                                      context: context,
                                      builder: (_) =>
                                          AlertDialog(
                                            title: Text(
                                                'Delete Product'),
                                            content: Text(
                                              'Are you sure you want to delete this product?',
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(
                                                      context,
                                                      false);
                                                },
                                                child:
                                                Text('Cancel'),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pop(
                                                      context,
                                                      true);
                                                },
                                                style:
                                                ElevatedButton
                                                    .styleFrom(
                                                  backgroundColor:
                                                  Colors.red,
                                                ),
                                                child:
                                                Text('Delete'),
                                              ),
                                            ],
                                          ),
                                    );

                                    if (confirm == true) {
                                      try {
                                        setState(() {
                                          isLoading = true;
                                        });

                                        await service
                                            .deleteProduct(
                                          product.id,
                                        );

                                        refresh();

                                        ScaffoldMessenger.of(
                                            context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Product deleted successfully',
                                            ),
                                            backgroundColor:
                                            Colors.green,
                                          ),
                                        );
                                      } catch (e) {
                                        ScaffoldMessenger.of(
                                            context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Delete failed',
                                            ),
                                            backgroundColor:
                                            Colors.red,
                                          ),
                                        );
                                      } finally {
                                        setState(() {
                                          isLoading = false;
                                        });
                                      }
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),

          // LOADER OVERLAY
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.3),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
      currentIndex: 0,
    );
  }
}