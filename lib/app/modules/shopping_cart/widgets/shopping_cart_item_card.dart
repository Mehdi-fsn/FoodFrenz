import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodfrenz/app/core/theme/colors.dart';
import 'package:foodfrenz/app/core/utils/dimensions.dart';
import 'package:foodfrenz/app/data/models/shopping_cart_item_model.dart';
import 'package:get/get.dart';

class ShoppingCartItemCard extends StatelessWidget {
  const ShoppingCartItemCard({Key? key, required this.item}) : super(key: key);

  final ShoppingCartItemModel item;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image
        AspectRatio(
          aspectRatio: 1,
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: item.image,
          ),
        ),
        SizedBox(width: Dimensions.width10),
        // Details
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.name,
              style: TextStyle(
                fontSize: Dimensions.textSizeLarge,
                color: Get.theme.colorScheme.onBackground,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$${item.price.toString()}',
                  style: TextStyle(
                    fontSize: Dimensions.textSizeMedium,
                    color: Get.theme.colorScheme.onBackground,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.width20,
                    vertical: Dimensions.height15,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                  ),
                  child: Row(children: [
                    GestureDetector(
                      onTap: () {
                        // TODO: decrement
                      },
                      child: const Icon(
                        Icons.remove,
                        color: AppColors.signColor,
                      ),
                    ),
                    SizedBox(width: Dimensions.width10),
                    Obx(
                      () => Text(
                        item.quantity.toString(),
                        style: TextStyle(
                            fontSize: Dimensions.textSizeLarge,
                            color: AppColors.textColor),
                      ),
                    ),
                    SizedBox(width: Dimensions.width10),
                    GestureDetector(
                      onTap: () {
                        // TODO: increment
                      },
                      child: const Icon(
                        Icons.add,
                        color: AppColors.signColor,
                      ),
                    ),
                  ]),
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}
