import 'package:flutter/material.dart';
import 'package:grocery_task/home/models/product.dart';
import 'package:grocery_task/home/repository/wishlist_repository.dart';

class WishlistProvider extends ChangeNotifier {
  WishlistRepository wishlistRepository;
  List<Product> wishlist = [];

  WishlistProvider(this.wishlistRepository) {
    _loadProductsToWishlist();
  }

  void toggleFavoriteList(Product product) {
    if (wishlist.any((element) => element.name == product.name)) {
      wishlistRepository.deleteProductFromFirestore(product);
      notifyListeners();
    } else {
      wishlistRepository.addProductToFirestore(product);
      notifyListeners();
    }
  }

  void _loadProductsToWishlist() {
    wishlistRepository.getWishlistStream().listen((product) {
      wishlist.clear();
      wishlist.addAll(product);
      notifyListeners();
    });
  }
}
