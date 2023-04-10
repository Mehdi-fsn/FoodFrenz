import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodfrenz/app/data/models/carte_item_model.dart';
import 'package:foodfrenz/app/data/models/shopping_cart_item_model.dart';
import 'package:get/get.dart';

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

  Stream<List<ShoppingCartItemModel>> getCart(String userId) {
    return FirebaseFirestore.instance
        .collection('carts')
        .doc(userId)
        .snapshots()
        .map((doc) {
      return doc.get('items').map<ShoppingCartItemModel>(
        (item) {
          return ShoppingCartItemModel.fromJson(item);
        },
      ).toList();
    });
  }

  Future<void> addToCart(String userId, ShoppingCartItemModel item) async {
    CollectionReference carts = FirebaseFirestore.instance.collection('carts');
    DocumentReference cartRef = carts.doc(userId);

    DocumentSnapshot cartSnapshot = await cartRef.get();

    bool itemExists = false;
    int existingItemIndex = -1;
    List<dynamic> items = cartSnapshot.get('items');

    for (int i = 0; i < items.length; i++) {
      if (items[i]['id'] == item.id) {
        itemExists = true;
        existingItemIndex = i;
        break;
      }
    }

    try {
      if (itemExists) {
        items[existingItemIndex]['quantity'] += item.quantity;
        await cartRef.update({'items': items});
      } else {
        await cartRef.update({
          'items': FieldValue.arrayUnion([item.toJson()])
        });
      }
      Get.snackbar('Success', 'Item has been successfully added to cart');
    } on FirebaseException catch (e) {
      Get.snackbar("Error", e.message!);
    }
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
