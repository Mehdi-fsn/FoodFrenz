import 'package:foodfrenz/app/data/models/order_item_model.dart';
import 'package:foodfrenz/app/modules/authentication/authentication_controller.dart';
import 'package:foodfrenz/app/modules/order_history/orders_history_repository.dart';
import 'package:get/get.dart';

class OrdersHistoryController extends GetxController {
  final OrdersHistoryRepository ordersHistoryRepository;

  OrdersHistoryController({required this.ordersHistoryRepository});

  final String userId = Get.find<AuthenticationController>().user!.uid;
  final ordersHistory = <OrderItemModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    ordersHistory.bindStream(ordersHistoryRepository.getOrdersHistory(userId));
  }

  int totalOrderQuantity(OrderItemModel order) {
    int total = 0;
    for (var element in order.items) {
      total += element.quantity;
    }
    return total;
  }
}
