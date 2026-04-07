import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main_scaffold.dart';
import '../provider/cart_model.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              "Items in Cart: ${context.watch<CartModel>().count}",
              style: TextStyle(fontSize: 20),
            ),
          ),

          Expanded(
            child: Consumer<CartModel>(
              builder: (context, cart, child) {
                return ListView(
                  children: cart.items.map((item) {
                    return ListTile(
                      title: Text(item),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          context.read<CartModel>().removeItem(item);
                        },
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),

          ElevatedButton(
            onPressed: () {
              context.read<CartModel>().addItem(
                "Item ${DateTime.now().second}",
              );
            },
            child: Text("Add Item"),
          ),
        ],
      ),
    );
  }
}