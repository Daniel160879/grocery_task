import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grocery_task/home/models/category.dart';

class CategoryRepository {
  Stream<List<Category>> getCategoriesStream() {
    return FirebaseFirestore.instance.collection('categories').snapshots().map(
      (snapshot) {
        return snapshot.docs.map((doc) => Category.fromJson(doc.data())).toList();
      },
    );
  }
}
