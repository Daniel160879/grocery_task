import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grocery_task/home/models/cart.dart';

class CartRepository {
  Stream<List<Cart>> getCardStream() {
    return FirebaseFirestore.instance.collection('card').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Cart.fromJson(doc.data())).toList();
    });
  }
}
