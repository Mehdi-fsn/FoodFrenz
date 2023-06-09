import 'package:foodfrenz/app/data/models/order_item_model.dart';
import 'package:foodfrenz/app/data/models/shopping_cart_item_model.dart';
import 'package:foodfrenz/app/data/providers/cloud_firestore_provider.dart';

class ShoppingCartRepository {
  final CloudFirestoreProvider cloudFirestoreProvider;

  ShoppingCartRepository({required this.cloudFirestoreProvider});

  Stream<List<ShoppingCartItemModel>> getCart(String userId) =>
      cloudFirestoreProvider.getCart(userId);

  Future<void> addToCart(String userId, ShoppingCartItemModel item) async {
    await cloudFirestoreProvider.addToCart(userId, item);
  }

  Future<void> removedItemInCart(
      String userId, ShoppingCartItemModel item) async {
    await cloudFirestoreProvider.removedItemInCart(userId, item);
  }

  Future<void> clearCart(String userId) async {
    await cloudFirestoreProvider.clearCart(userId);
  }

  Future<void> updateItemQuantity(
      String userId, ShoppingCartItemModel item) async {
    await cloudFirestoreProvider.updateItemQuantity(userId, item);
  }

  Future<void> placeOrder(String userId, OrderItemModel item) async {
    await cloudFirestoreProvider.placeOrder(userId, item);
  }
}
