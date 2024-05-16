import 'package:flutter/material.dart';
import 'package:grocery_task/home/models/cart.dart';
import 'package:grocery_task/home/models/product.dart';
import 'package:grocery_task/home/provider/cart_provider.dart';
import 'package:provider/provider.dart';

class CartlistPage extends StatefulWidget {
  const CartlistPage({Key? key}) : super(key: key);

  @override
  State<CartlistPage> createState() => _CardlistPageState();
}

class _CardlistPageState extends State<CartlistPage> {
  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CartProvider>();
    return ListView(
      children: [
        Text(
          'Wishlist',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 16),
        if (cartProvider.cart.items.isEmpty)
          const Center(
            child: Text('Your Cart is empty'),
          ),
      ],
    );
  }
}
