import 'package:flutter/material.dart';
import '../models/product.dart';
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

  final ProductService service = ProductService();

  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late TextEditingController priceController;

  bool isEdit = false;

  @override
  void initState() {
    super.initState();

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
          );
        } else {
          await service.addProduct(product);
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
            content: Text('Operation failed'),
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
          child: Column(
            children: [
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
    );
  }
}