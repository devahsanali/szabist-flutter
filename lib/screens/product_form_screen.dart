import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../models/product.dart';
import '../provider/auth_provider.dart';
import '../services/api_client.dart';
import '../services/product_service.dart';

class ProductFormScreen extends StatefulWidget {
  final Product? product;

  ProductFormScreen({this.product});

  @override
  State<ProductFormScreen> createState() =>
      _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _formKey = GlobalKey<FormState>();

  late ProductService service;
  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late TextEditingController priceController;

  bool isEdit = false;
  File? selectedImage;

  @override
  void initState() {
    super.initState();
    final auth = Provider.of<AuthProvider>(context, listen: false);
    final apiClient = ApiClient(auth);
    service = ProductService(apiClient);

    isEdit = widget.product != null;

    nameController = TextEditingController(
      text: widget.product?.name ?? '',
    );

    descriptionController = TextEditingController(
      text: widget.product?.description ?? '',
    );

    priceController = TextEditingController(
      text: widget.product?.price.toString() ?? '',
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
    }
  }

  void saveProduct() async {
    if (_formKey.currentState!.validate()) {
      try {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => Center(
            child: CircularProgressIndicator(),
          ),
        );

        final product = Product(
          id: widget.product?.id ?? '',
          name: nameController.text,
          description: descriptionController.text,
          price: double.parse(priceController.text),
        );

        if (isEdit) {
          await service.updateProduct(
            widget.product!.id,
            product,
            imagePath: selectedImage?.path,
          );
        } else {
          await service.addProduct(
            product,
            imagePath: selectedImage?.path,
          );
        }

        Navigator.pop(context);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              isEdit
                  ? 'Product updated successfully'
                  : 'Product added successfully',
            ),
            backgroundColor: Colors.green,
          ),
        );

        Navigator.pop(context, true);
      } catch (e) {
        Navigator.pop(context);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Operation failed: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEdit ? 'Edit Product' : 'Add Product',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Image Picker Section
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: selectedImage != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              selectedImage!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 200,
                            ),
                          )
                        : (widget.product?.image != null
                            // Existing image from server
                            ? Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      widget.product!.image!,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: 200,
                                      errorBuilder: (context, error, stackTrace) =>
                                          Container(
                                            width: double.infinity,
                                            height: 200,
                                            color: Colors.grey[200],
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons.broken_image, size: 50, color: Colors.grey),
                                                SizedBox(height: 8),
                                                Text('Tap to change image'),
                                              ],
                                            ),
                                          ),
                                    ),
                                  ),
                                  // Overlay hint
                                  Positioned(
                                    bottom: 8,
                                    right: 8,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: Colors.black54,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(Icons.edit, color: Colors.white, size: 14),
                                          SizedBox(width: 4),
                                          Text('Change', style: TextStyle(color: Colors.white, fontSize: 12)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            // No image yet
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.add_photo_alternate, size: 50, color: Colors.grey),
                                  SizedBox(height: 10),
                                  Text('Tap to select image'),
                                ],
                              )),
                  ),
                ),

                SizedBox(height: 20),

                TextFormField(
                  controller: nameController,
                  decoration:
                  InputDecoration(labelText: 'Name'),
                  validator: (value) =>
                  value!.isEmpty ? 'Required' : null,
                ),

                TextFormField(
                  controller: descriptionController,
                  decoration:
                  InputDecoration(labelText: 'Description'),
                ),

                TextFormField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration:
                  InputDecoration(labelText: 'Price'),
                ),

                SizedBox(height: 20),

                ElevatedButton(
                  onPressed: saveProduct,
                  child: Text(
                    isEdit ? 'Update Product' : 'Add Product',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}