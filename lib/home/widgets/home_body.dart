import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:grocery_task/home/models/cart.dart';
import 'package:grocery_task/home/models/product.dart';
import 'package:grocery_task/home/provider/cart_provider.dart';
import 'package:grocery_task/home/provider/products_provider.dart';
import 'package:grocery_task/home/widgets/action_headline.dart';
import 'package:grocery_task/home/widgets/categories_section.dart';
import 'package:grocery_task/home/widgets/hero_image.dart';
import 'package:grocery_task/home/widgets/product_item.dart';
import 'package:provider/provider.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({
    Key? key,
    required this.cart,
    required this.wishlist,
  }) : super(key: key);

  final Cart cart;
  final List<Product> wishlist;

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  Widget build(BuildContext context) {
    final productModel = context.watch<ProductsProvider>();
    return ListView(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: const TextField(
            decoration: InputDecoration(
              hintText: 'Search keywords..',
              prefixIcon: Icon(Icons.search),
              fillColor: Color(0xffe4e5e9),
              filled: true,
              border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(height: 20),
        const HeroImage(),
        const SizedBox(height: 20),
        const CategoriesSection(),
        const SizedBox(height: 20),
        const ActionHeadline(title: 'Featured products'),
        const SizedBox(height: 12),
        Wrap(
          runSpacing: 20,
          alignment: WrapAlignment.spaceBetween,
          children: [
            for (final product in productModel.products)
              Consumer<CartProvider>(builder: (context, model, child) {
                return ProductItem(
                  product: product,
                  quantity: model.cart.items
                      .firstWhere((element) => element.product == product, orElse: () => CartItem(product, 0))
                      .quantity,
                );
              }),
            if (productModel.isLoading) const Center(child: LinearProgressIndicator()),
            if (productModel.products.isEmpty)
              ElevatedButton(
                  onPressed: productModel.isLoading
                      ? null
                      : () async {
                          await context.read<ProductsProvider>().uploadProductsFirestore();
                        },
                  child: const Text('upload bttn'))
          ],
        ),
      ].animate(interval: const Duration(milliseconds: 100)).fadeIn(),
    );
  }
}
