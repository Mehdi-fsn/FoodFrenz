import 'package:flutter/material.dart';
import 'package:foodfrenz/app/core/constant/constants.dart';
import 'package:foodfrenz/app/core/theme/colors.dart';
import 'package:foodfrenz/app/core/utils/dimensions.dart';
import 'package:foodfrenz/app/data/models/shopping_cart_item_model.dart';
import 'package:foodfrenz/app/modules/shopping_cart/shopping_cart_controller.dart';
import 'package:foodfrenz/app/modules/shopping_cart/widgets/shopping_cart_item_card.dart';
import 'package:get/get.dart';

class ShoppingCartScreen extends GetView<ShoppingCartController> {
  const ShoppingCartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // Header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  Constants.shoppingCart,
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
                  child: Icon(Icons.shopping_cart_outlined,
                      color: Get.isDarkMode ? Colors.black87 : Colors.white),
                ),
              ],
            ),
          ),
          // List of items
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.width10),
              child: Obx(
                () => ListView.builder(
                  padding: EdgeInsets.only(top: Dimensions.height5),
                  itemCount: controller.shoppingCart.length,
                  itemBuilder: (_, int index) {
                    final ShoppingCartItemModel item =
                        controller.shoppingCart[index];
                    return ShoppingCartItemCard(item: item);
                  },
                ),
              ),
            ),
          ),
          Container(
            height: Dimensions.height70,
            padding: EdgeInsets.symmetric(horizontal: Dimensions.width10),
            decoration: BoxDecoration(
              color: Get.isDarkMode ? Colors.black26 : Colors.grey.shade200,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.width20,
                    vertical: Dimensions.height10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(Dimensions.radius10),
                  ),
                  child: Obx(
                    () => Text(
                      'Total: \$${controller.totalPrice}',
                      style: TextStyle(
                          fontSize: Dimensions.textSizeLarge,
                          color: AppColors.textColor),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.width20,
                    vertical: Dimensions.height10,
                  ),
                  decoration: BoxDecoration(
                    color: Get.isDarkMode
                        ? AppColors.mainDarkColor
                        : AppColors.mainColor,
                    borderRadius: BorderRadius.circular(Dimensions.radius10),
                  ),
                  child: Text(
                    "Check Out",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Dimensions.textSizeLarge,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
