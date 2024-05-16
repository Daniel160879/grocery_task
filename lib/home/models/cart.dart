import 'package:grocery_task/home/models/product.dart';

class Cart {
  List<CartItem> items;

  Cart(this.items);

  Map<String, dynamic> toJson() {
    return {'items': items};
  }

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(json['items']);
  }
}

class CartItem {
  final Product product;
  int quantity;

  CartItem(
    this.product,
    this.quantity,
  );
  Map<String, dynamic> toJson() {
    return {'product': product, 'quantity': quantity};
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(json['product'], json['quantity']);
  }
}
