import 'package:flutter/material.dart';
import 'package:grocery_task/app.dart';
import 'package:grocery_task/home/models/cart.dart';
import 'package:grocery_task/home/provider/cart_provider.dart';
import 'package:grocery_task/home/provider/categories_provider.dart';
import 'package:grocery_task/home/provider/products_provider.dart';
import 'package:grocery_task/home/provider/wishlist_provider.dart';
import 'package:grocery_task/home/repository/cart_repository.dart';
import 'package:grocery_task/home/repository/categories_repository.dart';
import 'package:grocery_task/home/repository/products_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:grocery_task/home/repository/wishlist_repository.dart';
import 'firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final prefs = await SharedPreferences.getInstance();
  Cart cart = Cart([]);
  CartRepository cartRepository = CartRepository();
  WishlistRepository wishlistRepository = WishlistRepository();
  ProductsRepository productsRepository = ProductsRepository();
  CategoryRepository categoryRepository = CategoryRepository();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CartProvider(cartRepository, cart),
        ),
        ChangeNotifierProvider(
          create: (context) => WishlistProvider(wishlistRepository),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductsProvider(productsRepository),
        ),
        ChangeNotifierProvider(
          create: (context) => CategoriesProvider(categoryRepository),
        ),
      ],
      child: App(
        preferences: prefs,
      ),
    ),
  );
}
