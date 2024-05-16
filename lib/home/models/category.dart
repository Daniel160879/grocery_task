import 'package:flutter/cupertino.dart';
import 'package:grocery_task/home/utils/colors.dart';

class Category {
  final String name;
  final String iconAsset;
  final Color color;

  const Category({required this.name, required this.iconAsset, required this.color});

  Map<String, dynamic> toJson() {
    return {'name': name, 'iconAsset': iconAsset, 'color': toHex(color)};
  }

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(name: json['name'], iconAsset: json['iconAsset'], color: fromHex(json['color']));
  }
}
