import 'package:foodfrenz/app/data/models/order_item_model.dart';
import 'package:foodfrenz/app/data/providers/cloud_firestore_provider.dart';

class OrdersHistoryRepository {
  final CloudFirestoreProvider cloudFirestoreProvider;

  OrdersHistoryRepository({required this.cloudFirestoreProvider});

  Stream<List<OrderItemModel>> getOrdersHistory(String userId) =>
      cloudFirestoreProvider.getOrdersHistory(userId);

  Future<void> changeStatusOrder(String userId, String orderId, int status) =>
      cloudFirestoreProvider.changeStatusOrder(userId, orderId, status);
}
