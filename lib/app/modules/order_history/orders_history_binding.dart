import 'package:foodfrenz/app/modules/order_history/orders_history_controller.dart';
import 'package:foodfrenz/app/modules/order_history/orders_history_repository.dart';
import 'package:get/get.dart';

class OrdersHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
        () => OrdersHistoryRepository(cloudFirestoreProvider: Get.find()));
    Get.lazyPut(
        () => OrdersHistoryController(ordersHistoryRepository: Get.find()));
  }
}
