import 'package:flutter/material.dart';
import 'package:grocery_task/home/models/category.dart';
import 'package:grocery_task/home/repository/categories_repository.dart';

class CategoriesProvider with ChangeNotifier {
  final CategoryRepository categoryRepository;
  final List<Category> _categories = [];

  List<Category> get categories => _categories;

  CategoriesProvider(this.categoryRepository) {
    _loadCategories();
  }

  void _loadCategories() {
    categoryRepository.getCategoriesStream().listen((categories) {
      _categories.clear();
      _categories.addAll(categories);
      notifyListeners();
    });
  }
}
