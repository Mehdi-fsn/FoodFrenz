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
}
