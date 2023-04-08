import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodfrenz/app/data/models/carte_item_model.dart';

class CloudFirestoreProvider {
  Stream<List<CarteItemModel>> getAppetizers() {
    return FirebaseFirestore.instance
        .collection('appetizers')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map(
        (doc) {
          return CarteItemModel.fromJson(doc.data(), id: doc.id);
        },
      ).toList();
    });
  }

  Stream<List<CarteItemModel>> getMainCourses() {
    return FirebaseFirestore.instance
        .collection('main_courses')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map(
        (doc) {
          return CarteItemModel.fromJson(doc.data(), id: doc.id);
        },
      ).toList();
    });
  }

  Stream<List<CarteItemModel>> getDesserts() {
    return FirebaseFirestore.instance
        .collection('desserts')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map(
        (doc) {
          return CarteItemModel.fromJson(doc.data(), id: doc.id);
        },
      ).toList();
    });
  }

  Future<void> createEmptyCart(String userId) async {
    bool exists = await checkIfCartExists(userId);
    if (!exists) {
      CollectionReference carts =
          FirebaseFirestore.instance.collection('carts');
      await carts.doc(userId).set({'items': []});
    }
  }

  Future<bool> checkIfCartExists(String userId) async {
    CollectionReference carts = FirebaseFirestore.instance.collection('carts');
    DocumentSnapshot cart = await carts.doc(userId).get();
    return cart.exists;
  }
}
