import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grocery_task/home/models/product.dart';

class WishlistRepository {
  Stream<List<Product>> getWishlistStream() {
    return FirebaseFirestore.instance.collection('wishlist').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Product.fromJson(doc.data())).toList();
    });
  }

  Future<void> addProductToFirestore(Product product) async {
    await FirebaseFirestore.instance.collection('wishlist').add(product.toJson());
  }

  Future<void> deleteProductFromFirestore(Product product) async {
    await FirebaseFirestore.instance
        .collection('wishlist')
        .where('name', isEqualTo: product.name)
        .get()
        .then((snapshot) => snapshot.docs.forEach((doc) {
              doc.reference.delete();
            }));
  }
}
