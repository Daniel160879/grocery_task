import 'package:flutter/material.dart';
import 'package:grocery_task/home/models/product.dart';
import 'package:grocery_task/home/provider/wishlist_provider.dart';
import 'package:provider/provider.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final wishlistProvider = context.watch<WishlistProvider>();
    return ListView(
      children: [
        Text(
          'Wishlist',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 16),
        if (wishlistProvider.wishlist.isEmpty)
          const Center(
            child: Text('Your wishlist is empty'),
          ),
        for (Product product in wishlistProvider.wishlist)
          ListTile(
            onTap: () {},
            title: Text(product.name),
            trailing: IconButton(
              onPressed: () {
                context.read<WishlistProvider>().deleteProduct(product);
              },
              icon: const Icon(Icons.delete),
            ),
          ),
      ],
    );
  }
}
