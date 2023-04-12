import 'package:flutter/material.dart';
import 'package:foodfrenz/app/core/constant/constants.dart';
import 'package:foodfrenz/app/core/theme/colors.dart';
import 'package:foodfrenz/app/core/utils/dimensions.dart';
import 'package:foodfrenz/app/modules/order_history/orders_history_controller.dart';
import 'package:foodfrenz/app/modules/order_history/widgets/order_item_card.dart';
import 'package:get/get.dart';

class OrdersHistoryScreen extends GetView<OrdersHistoryController> {
  const OrdersHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  Constants.orderHistory,
                  style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? AppColors.mainDarkColor
                          : AppColors.mainColor,
                      fontSize: Dimensions.textSize30,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  width: Dimensions.height45,
                  height: Dimensions.height45,
                  decoration: BoxDecoration(
                    color: Get.isDarkMode
                        ? AppColors.mainDarkColor
                        : AppColors.mainColor,
                    borderRadius: BorderRadius.circular(Dimensions.radius10),
                  ),
                  child: Icon(Icons.receipt_long_outlined,
                      color: Get.isDarkMode ? Colors.black87 : Colors.white),
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(
              () => ListView.builder(
                padding: EdgeInsets.only(top: Dimensions.height5),
                itemCount: controller.ordersHistory.length,
                itemBuilder: (_, int index) {
                  return OrderItemCard(item: controller.ordersHistory[index]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
