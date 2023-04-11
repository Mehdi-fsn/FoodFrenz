import 'package:flutter/material.dart';
import 'package:foodfrenz/app/core/utils/dimensions.dart';
import 'package:foodfrenz/app/modules/order_history/orders_history_controller.dart';
import 'package:get/get.dart';

class OrdersHistoryScreen extends GetView<OrdersHistoryController> {
  const OrdersHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.width10),
      child: Obx(
        () => ListView.builder(
          padding: EdgeInsets.only(top: Dimensions.height5),
          itemCount: controller.ordersHistory.length,
          itemBuilder: (_, int index) {
            return ListTile(
              title: Text(controller.ordersHistory[index].total.toString()),
              subtitle: Text(controller.ordersHistory[index].date.toString()),
            );
          },
        ),
      ),
    );
  }
}
