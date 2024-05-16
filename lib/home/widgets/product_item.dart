import 'package:flutter/material.dart';
import 'package:grocery_task/home/models/product.dart';
import 'package:grocery_task/home/provider/cart_provider.dart';
import 'package:grocery_task/home/provider/wishlist_provider.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    required this.product,
    required this.quantity,
  });

  final Product product;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (product.badge != null)
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: product.badge!.color.withOpacity(0.2),
                    ),
                    child: Text(
                      product.badge!.name,
                      style: TextStyle(
                        color: product.badge!.color,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  context.read<WishlistProvider>().toggleFavoriteList(product);
                },
                icon: Consumer<WishlistProvider>(builder: (context, model, child) {
                  final isFavorite = model.wishlist.contains(product);
                  return Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border_rounded,
                    color: isFavorite ? Colors.red : null,
                  );
                }),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    CircleAvatar(
                      backgroundColor: product.color,
                      radius: 50,
                    ),
                    Positioned(
                      bottom: -15,
                      left: 0,
                      right: 0,
                      child: Image.asset(
                        product.imageAsset,
                        width: 150,
                        height: 75,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 28),
                Text(
                  '\$${product.price}',
                  style: const TextStyle(color: Colors.green),
                ),
                Text(
                  product.name,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  product.description,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          const Divider(),
          if (quantity > 0)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    context.read<CartProvider>().onRemoveItem(product);
                  },
                  icon: const Icon(Icons.remove),
                ),
                Text(
                  quantity.toString(),
                ),
                IconButton(
                  onPressed: () {
                    context.read<CartProvider>().onAddItem(product);
                  },
                  icon: const Icon(Icons.add),
                ),
              ],
            )
          else
            TextButton(
              onPressed: () {
                context.read<CartProvider>().onAddItem(product);
              },
              child: const Text('Add to cart'),
            ),
        ],
      ),
    );
  }
}
