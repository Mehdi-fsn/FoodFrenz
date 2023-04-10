import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodfrenz/app/core/theme/colors.dart';
import 'package:foodfrenz/app/core/utils/dimensions.dart';
import 'package:foodfrenz/app/data/models/shopping_cart_item_model.dart';
import 'package:foodfrenz/app/modules/shopping_cart/shopping_cart_controller.dart';
import 'package:get/get.dart';

class ShoppingCartItemCard extends GetView<ShoppingCartController> {
  const ShoppingCartItemCard({Key? key, required this.item}) : super(key: key);

  final ShoppingCartItemModel item;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(item.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) {
        controller.removedItemInCart(item);
      },
      background: Container(
        padding: EdgeInsets.only(right: Dimensions.width20),
        alignment: Alignment.centerRight,
        color: Colors.red,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      child: Container(
        margin: EdgeInsets.only(bottom: Dimensions.height10),
        height: Dimensions.height80,
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: CachedNetworkImage(
                imageUrl: item.image,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius15),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) => const Center(
                  child: SizedBox.shrink(),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            SizedBox(width: Dimensions.width10),
            // Details
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: Dimensions.height5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: TextStyle(
                        fontSize: Dimensions.textSizeLarge,
                        fontWeight: FontWeight.w500,
                        color: Get.isDarkMode
                            ? Get.theme.colorScheme.onBackground
                            : Colors.black54,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$ ${item.price.toString()}',
                          style: TextStyle(
                            fontSize: Dimensions.textSizeLarge,
                            fontWeight: FontWeight.w500,
                            color: Get.isDarkMode
                                ? Get.theme.colorScheme.onBackground
                                : Colors.black54,
                          ),
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                controller.updateItemQuantity(
                                    item, item.quantity - 1);
                              },
                              child: const Icon(
                                Icons.remove,
                                color: AppColors.signColor,
                              ),
                            ),
                            SizedBox(width: Dimensions.width5),
                            Obx(
                              () => Text(
                                controller.shoppingCart
                                    .firstWhere(
                                        (element) => element.id == item.id)
                                    .quantity
                                    .toString(),
                                style: TextStyle(
                                    fontSize: Dimensions.textSizeLarge,
                                    color: AppColors.textColor),
                              ),
                            ),
                            SizedBox(width: Dimensions.width5),
                            GestureDetector(
                              onTap: () {
                                controller.updateItemQuantity(
                                    item, item.quantity + 1);
                              },
                              child: const Icon(
                                Icons.add,
                                color: AppColors.signColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
