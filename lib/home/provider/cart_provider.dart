import 'package:flutter/material.dart';
import 'package:grocery_task/home/models/cart.dart';
import 'package:grocery_task/home/models/product.dart';
import 'package:grocery_task/home/repository/cart_repository.dart';

class CartProvider extends ChangeNotifier {
  CartRepository cartRepository;
  Cart cart;

  final cartList = [];

  CartProvider(this.cartRepository, this.cart) {
    _loadCartToCartlist();
  }

  void onAddItem(Product product) {
    if (cart.items.any((element) => element.product == product)) {
      cart.items.firstWhere((element) => element.product == product).quantity++;
      cartRepository.addCartToFirebase(cart);
      notifyListeners();
      return;
    } else {
      cart.items.add(CartItem(product, 1));
      notifyListeners();
    }
  }

  void onRemoveItem(Product product) {
    if (cart.items.any((element) => element.product == product) &&
        cart.items.firstWhere((element) => element.product == product).quantity > 1) {
      cart.items.firstWhere((element) => element.product == product).quantity--;
      cartList.add(cart.items);
      notifyListeners();
      return;
    } else {
      cart.items.removeWhere((element) => element.product == product);
      notifyListeners();
      return;
    }
  }

  void _loadCartToCartlist() {
    final stream = cartRepository.getCardStream();
    stream.listen(
      (product) {
        cartList.clear();
        cartList.addAll(product);
        notifyListeners();
      },
    );
  }
}
