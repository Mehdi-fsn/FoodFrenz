import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodfrenz/app/data/models/carte_item_model.dart';
import 'package:foodfrenz/app/data/models/order_item_model.dart';
import 'package:foodfrenz/app/data/models/shopping_cart_item_model.dart';
import 'package:get/get.dart';

class CloudFirestoreProvider {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<CarteItemModel>> getAppetizers() {
    return _firestore.collection('appetizers').snapshots().map((querySnapshot) {
      return querySnapshot.docs.map(
        (doc) {
          return CarteItemModel.fromJson(doc.data(), id: doc.id);
        },
      ).toList();
    });
  }

  Stream<List<CarteItemModel>> getMainCourses() {
    return _firestore
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
    return _firestore.collection('desserts').snapshots().map((querySnapshot) {
      return querySnapshot.docs.map(
        (doc) {
          return CarteItemModel.fromJson(doc.data(), id: doc.id);
        },
      ).toList();
    });
  }

  // Shopping Cart
  Stream<List<ShoppingCartItemModel>> getCart(String userId) {
    return _firestore.collection('carts').doc(userId).snapshots().map((doc) {
      return doc.get('items').map<ShoppingCartItemModel>(
        (item) {
          return ShoppingCartItemModel.fromJson(item);
        },
      ).toList();
    });
  }

  Future<void> createEmptyCart(String userId) async {
    bool exists = await checkIfCartExists(userId);
    if (!exists) {
      CollectionReference carts = _firestore.collection('carts');
      await carts.doc(userId).set({'items': []});
    }
  }

  Future<bool> checkIfCartExists(String userId) async {
    DocumentSnapshot cart =
        await _firestore.collection('carts').doc(userId).get();
    return cart.exists;
  }

  Future<void> addToCart(String userId, ShoppingCartItemModel item) async {
    CollectionReference carts = _firestore.collection('carts');
    DocumentReference cartRef = carts.doc(userId);

    DocumentSnapshot cartSnapshot = await cartRef.get();

    bool itemExists = false;
    List<dynamic> items = cartSnapshot.get('items');

    for (int i = 0; i < items.length; i++) {
      if (items[i]['id'] == item.id) {
        itemExists = true;
        break;
      }
    }

    try {
      if (itemExists) {
        Get.snackbar("Information", "Item already exists in cart");
      } else {
        await cartRef.update({
          'items': FieldValue.arrayUnion([item.toJson()])
        });
        Get.snackbar('Success', 'Item has been successfully added to cart');
      }
    } on FirebaseException catch (_) {
      Get.snackbar("Error", 'Failed to add item to cart');
    }
  }

  Future<void> removedItemInCart(
      String userId, ShoppingCartItemModel item) async {
    CollectionReference carts = _firestore.collection('carts');
    DocumentReference cartRef = carts.doc(userId);

    DocumentSnapshot cartSnapshot = await cartRef.get();

    List<dynamic> items = cartSnapshot.get('items');
    var itemIndex = items.indexWhere((element) => element['id'] == item.id);

    try {
      items.removeAt(itemIndex);
      await cartRef.update({'items': items});
      Get.snackbar('Success', 'Item has been successfully removed from cart');
    } on FirebaseException catch (_) {
      Get.snackbar("Error", 'Failed to remove item from cart');
    }
  }

  Future<void> updateItemQuantity(
      String userId, ShoppingCartItemModel item) async {
    CollectionReference carts = _firestore.collection('carts');
    DocumentReference cartRef = carts.doc(userId);

    DocumentSnapshot cartSnapshot = await cartRef.get();

    List<dynamic> items = cartSnapshot.get('items');
    var itemIndex = items.indexWhere((element) => element['id'] == item.id);

    try {
      items[itemIndex]['quantity'] = item.quantity;
      await cartRef.update({'items': items});
    } on FirebaseException catch (_) {
      Get.snackbar("Error", 'Failed to update item quantity');
    }
  }

  // Orders
  Stream<List<OrderItemModel>> getOrdersHistory(String userId) {
    return _firestore.collection('orders').doc(userId).snapshots().map((doc) {
      return doc.get('orders').map<OrderItemModel>(
        (order) {
          return OrderItemModel.fromJson(order);
        },
      ).toList();
    });
  }

  Future<void> createEmptyOrderHistory(String userId) async {
    bool exists = await checkIfOrdersHistoryExists(userId);
    if (!exists) {
      CollectionReference carts = _firestore.collection('orders');
      await carts.doc(userId).set({'orders': []});
    }
  }

  Future<bool> checkIfOrdersHistoryExists(String userId) async {
    DocumentSnapshot order =
        await _firestore.collection('orders').doc(userId).get();
    return order.exists;
  }
}
