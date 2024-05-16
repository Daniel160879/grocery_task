import 'dart:ui';
import 'package:grocery_task/home/models/category.dart';
import 'package:grocery_task/home/utils/colors.dart';

class Product {
  final String name;
  final String description;
  final double price;
  final Category? category;

  final String imageAsset;

  final Color color;

  final ProductBadge? badge;

  const Product({
    required this.name,
    required this.description,
    required this.price,
    required this.imageAsset,
    required this.color,
    this.category,
    this.badge,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'imageAsset': imageAsset,
      'color': toHex(color),
      'category': category?.toJson(),
      'badge': badge?.toJson(),
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      description: json['description'],
      price: double.parse((json['price'] as double).toString()),
      imageAsset: json['imageAsset'],
      color: fromHex(json['color']),
      category: json['category'] != null ? Category.fromJson(json['category']) : null,
      badge: json['badge'] != null
          ? ProductBadge.fromJson(
              json['badge'],
            )
          : null,
    );
  }
}

class ProductBadge {
  final String name;
  final Color color;

  const ProductBadge({
    required this.name,
    required this.color,
  });
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'color': toHex(color),
    };
  }

  factory ProductBadge.fromJson(Map<String, dynamic> json) {
    return ProductBadge(
      name: json['name'],
      color: fromHex(json['color']),
    );
  }
}
