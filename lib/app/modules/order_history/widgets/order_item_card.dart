import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodfrenz/app/core/theme/colors.dart';
import 'package:foodfrenz/app/core/utils/dimensions.dart';
import 'package:foodfrenz/app/core/utils/format.dart';
import 'package:foodfrenz/app/data/models/order_item_model.dart';
import 'package:foodfrenz/app/data/models/shopping_cart_item_model.dart';
import 'package:foodfrenz/app/modules/order_history/orders_history_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrderItemCard extends GetView<OrdersHistoryController> {
  OrderItemCard({Key? key, required this.item}) : super(key: key);

  final OrderItemModel item;
  final List<Color> statusColor = [
    Colors.red.shade300,
    Colors.orange.shade300,
    Colors.green.shade300
  ];
  final List<IconData> statusIcon = [
    Icons.cancel_outlined,
    Icons.hourglass_top_outlined,
    Icons.check_circle_outline_outlined
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Get.theme.colorScheme.background,
        borderRadius: BorderRadius.circular(Dimensions.radius10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      margin: EdgeInsets.only(
        left: Dimensions.width15,
        right: Dimensions.width15,
        bottom: Dimensions.height15,
      ),
      padding: EdgeInsets.all(Dimensions.height10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order #${item.id}',
                    style: TextStyle(
                      color: Get.theme.colorScheme.onBackground,
                      fontSize: Dimensions.textSize13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    DateFormat('dd/MM/yyyy, hh:mm a').format(item.date),
                    style: TextStyle(
                      color: AppColors.paraColor,
                      fontSize: Dimensions.textSize11,
                    ),
                  ),
                ],
              ),
              Icon(
                Icons.receipt_long_outlined,
                size: Dimensions.iconSize30,
                color: Get.isDarkMode
                    ? AppColors.mainDarkColor
                    : AppColors.mainColor,
              ),
            ],
          ),
          SizedBox(height: Dimensions.height10),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: Dimensions.height200,
            ),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: item.items.length,
              itemBuilder: (_, int index) {
                return _buildCardItemFood(item.items[index]);
              },
            ),
          ),
          SizedBox(height: Dimensions.height5),
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Get.theme.colorScheme.onBackground.withOpacity(0.2),
                ),
              ),
            ),
            padding: EdgeInsets.only(top: Dimensions.height15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'x${controller.totalOrderQuantity(item)} item${item.items.length > 1 ? 's' : ''}',
                      style: TextStyle(
                        color: AppColors.paraColor,
                        fontSize: Dimensions.textSize11,
                      ),
                    ),
                    Text(
                      '\$${item.total.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Get.theme.colorScheme.onBackground,
                        fontSize: Dimensions.textSizeDefault,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: statusColor[item.status.index],
                    ),
                    borderRadius: BorderRadius.circular(Dimensions.radius5),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.width15,
                    vertical: Dimensions.height10,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        statusIcon[item.status.index],
                        size: Dimensions.iconSizeLarge,
                        color: statusColor[item.status.index],
                      ),
                      SizedBox(width: Dimensions.width5),
                      Text(
                        Format.formatStatusOrderToString(item.status),
                        style: TextStyle(
                          color: statusColor[item.status.index],
                          fontSize: Dimensions.textSize11,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardItemFood(ShoppingCartItemModel item) {
    return Container(
      padding: EdgeInsets.only(bottom: Dimensions.height10),
      height: Dimensions.height100,
      child: Row(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: CachedNetworkImage(
              imageUrl: item.image,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
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
          SizedBox(width: Dimensions.width20),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: Dimensions.height10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: TextStyle(
                      color: Get.theme.colorScheme.onBackground,
                      fontSize: Dimensions.textSizeMedium,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Loreem Ipsum is simply',
                    style: TextStyle(
                      color: AppColors.paraColor,
                      fontSize: Dimensions.textSize11,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${item.price.toString()}',
                        style: TextStyle(
                          color: Get.theme.colorScheme.onBackground,
                          fontSize: Dimensions.textSizeDefault,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Qty: ${item.quantity}',
                        style: TextStyle(
                          color: Get.theme.colorScheme.onBackground,
                          fontSize: Dimensions.textSize11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
