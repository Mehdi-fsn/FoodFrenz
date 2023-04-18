import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:foodfrenz/app/data/models/address_model.dart';
import 'package:foodfrenz/app/data/models/carte_item_model.dart';
import 'package:foodfrenz/app/data/models/order_item_model.dart';
import 'package:foodfrenz/app/data/models/shopping_cart_item_model.dart';
import 'package:foodfrenz/app/data/models/user_info_model.dart';
import 'package:foodfrenz/app/modules/authentication/authentication_controller.dart';
import 'package:get/get.dart';

class CloudFirestoreProvider {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // -------- Region User --------
  Future<void> createUser() async {
    final User user = Get.find<AuthenticationController>().user!;
    final isExists = await isUserExists(user.uid);
    if (!isExists) {
      CollectionReference users = _firestore.collection('users');
      await users.doc(user.uid).set({
        'createdAt': Timestamp.now(),
        'address': {},
        'transactions': 0,
        'spending': 0,
      });
    }
  }

  Future<bool> isUserExists(String userId) async {
    DocumentSnapshot documentSnapshot =
        await _firestore.collection('users').doc(userId).get();
    return documentSnapshot.exists;
  }

  Stream<UserInfoModel> getUser(String userId) {
    return _firestore.collection('users').doc(userId).snapshots().map(
      (doc) {
        return UserInfoModel.fromJson(doc.data()!, userId: doc.id);
      },
    );
  }

  Stream<User?> get userChanges => FirebaseAuth.instance.userChanges();

  Future<void> updateUserAuthProfile(
      String? displayName, String? email, String? photoUrl) async {
    final User user = FirebaseAuth.instance.currentUser!;
    try {
      if (displayName != null) {
        await user.updateDisplayName(displayName);
      }
      if (email != null) {
        await user.updateEmail(email);
      }
      if (photoUrl != null) {
        await user.updatePhotoURL(photoUrl);
      }
      Get.snackbar("Success", "Your profile has been updated");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> updateUserInfoProfile(String userId, UserInfoModel user) async {
    final CollectionReference users = _firestore.collection('users');
    final DocumentReference userRef = users.doc(userId);

    try {
      await userRef.update(user.toJson());
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  Future<AddressModel> getAddressLocation(String userId) async {
    final CollectionReference users = _firestore.collection('users');
    final DocumentReference userRef = users.doc(userId);

    final DocumentSnapshot userSnapshot = await userRef.get();
    final Map<String, dynamic> doc =
        userSnapshot.data()! as Map<String, dynamic>;

    final AddressModel address = AddressModel.fromJson(doc['address']);
    return address;
  }

  // -------- End Region User --------

  // -------- Region Carte --------
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

  // -------- End Region Carte --------

  // -------- Region Shopping Cart --------
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

  Stream<List<ShoppingCartItemModel>> getCart(String userId) {
    return _firestore.collection('carts').doc(userId).snapshots().map((doc) {
      return doc.get('items').map<ShoppingCartItemModel>(
        (item) {
          return ShoppingCartItemModel.fromJson(item);
        },
      ).toList();
    });
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

  Future<void> clearCart(String userId) async {
    CollectionReference carts = _firestore.collection('carts');
    DocumentReference cartRef = carts.doc(userId);

    try {
      await cartRef.update({'items': []});
    } on FirebaseException catch (_) {
      Get.snackbar("Error", 'Failed to clear cart');
    }
  }

  // -------- End Region Shopping Cart --------

  // -------- Region Orders --------
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

  Stream<List<OrderItemModel>> getOrdersHistory(String userId) {
    return _firestore.collection('orders').doc(userId).snapshots().map((doc) {
      return doc.get('orders').map<OrderItemModel>(
        (order) {
          return OrderItemModel.fromJson(order);
        },
      ).toList();
    });
  }

  Future<void> placeOrder(String userId, OrderItemModel order) async {
    CollectionReference orders = _firestore.collection('orders');
    DocumentReference orderRef = orders.doc(userId);

    DocumentSnapshot orderSnapshot = await orderRef.get();

    try {
      List<dynamic> existingOrders = orderSnapshot.get('orders');
      existingOrders.insertAll(0, [order.toJson()]);
      await orderRef.update({
        'orders': existingOrders,
      });
      Get.snackbar('Success', 'Order has been successfully placed');
    } on FirebaseException catch (_) {
      Get.snackbar("Error", 'Failed to place order');
    }
  }

  Future<void> changeStatusOrder(
      String userId, String orderId, int status) async {
    CollectionReference orders = _firestore.collection('orders');
    DocumentReference orderRef = orders.doc(userId);

    DocumentSnapshot orderSnapshot = await orderRef.get();

    try {
      List<dynamic> existingOrders = orderSnapshot.get('orders');
      var orderIndex =
          existingOrders.indexWhere((element) => element['id'] == orderId);
      existingOrders[orderIndex]['status'] = status;
      await orderRef.update({
        'orders': existingOrders,
      });
      switch (status) {
        case 0:
          Get.snackbar('Success', 'Order has been successfully cancelled');
          break;
        case 1:
          Get.snackbar('Success', 'Order is awaiting delivery');
          break;
        case 2:
          Get.snackbar('Success', 'Order has been successfully delivered');
          break;
      }
    } on FirebaseException catch (_) {
      Get.snackbar("Error", 'Failed to update order');
    }
  }

  // -------- End Region Orders --------

  // -------- Region Firebase Storage --------
  Future<String> uploadProfileImage(String userId, File? image) async {
    if (image == null) return '';

    Reference reference =
        FirebaseStorage.instance.ref().child('avatar/$userId.jpg');
    UploadTask uploadTask = reference.putFile(image);

    TaskSnapshot taskSnapshot = await uploadTask;
    return await taskSnapshot.ref.getDownloadURL();
  }
// -------- End Region Firebase Storage --------
}
