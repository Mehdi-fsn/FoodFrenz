import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodfrenz/app/core/constant/constants.dart';
import 'package:foodfrenz/app/core/theme/colors.dart';
import 'package:foodfrenz/app/core/utils/dimensions.dart';
import 'package:foodfrenz/app/data/models/carte_item_model.dart';
import 'package:foodfrenz/app/data/services/controllers/navigation_controller.dart';
import 'package:foodfrenz/app/modules/home/widgets/components/detailed_carte_item_card.dart';
import 'package:foodfrenz/app/routes/route_path.dart';
import 'package:foodfrenz/app/widgets/app_icon_widget.dart';
import 'package:foodfrenz/app/widgets/expandable_text_widget.dart';
import 'package:get/get.dart';

class CarteItemDetailsPage extends StatelessWidget {
  CarteItemDetailsPage({Key? key}) : super(key: key);

  final CarteItemModel item = Get.arguments;
  final ItemCountController countController = Get.put(ItemCountController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned(
            left: 0,
            top: 0,
            child: SizedBox(
              height: Dimensions.height350,
              width: Dimensions.screenWidth,
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: item.image,
              ),
            ),
          ),
          // Back Button and Cart Icon
          Positioned(
            top: Dimensions.height45,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(
                  icon: Icons.arrow_back,
                  onTap: () {
                    Get.back();
                  },
                ),
                AppIcon(
                  icon: Icons.shopping_cart_outlined,
                  onTap: () {
                    final navigator = Get.key.currentState;
                    while (navigator!.canPop()) {
                      navigator.pop();
                    }
                    Get.find<NavigationController>().changePage(2);
                    Get.offAllNamed(RoutePath.shoppingCartScreenPath, id: 1);
                  },
                ),
              ],
            ),
          ),
          // Item Details
          Positioned(
            top: Dimensions.height350 - Dimensions.height30,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.only(
                top: Dimensions.height20,
                right: Dimensions.width20,
                left: Dimensions.width20,
                bottom: Dimensions.height5,
              ),
              decoration: BoxDecoration(
                color: Get.theme.colorScheme.background,
                borderRadius: BorderRadius.circular(Dimensions.radius20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DetailedCarteItemCard(item: item, seePrice: true),
                  SizedBox(height: Dimensions.textSizeExtraLarge),
                  const Text(
                    Constants.introduce,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: Dimensions.height10),
                  Expanded(
                    child: SingleChildScrollView(
                      child: ExpandableTextWidget(
                        text: item.description,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: Dimensions.height120,
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.width20,
          vertical: Dimensions.height30,
        ),
        decoration: BoxDecoration(
          color: Get.isDarkMode ? Colors.black26 : Colors.grey.shade200,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimensions.radius30),
            topRight: Radius.circular(Dimensions.radius30),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
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
                    countController.decrement();
                  },
                  child: const Icon(
                    Icons.remove,
                    color: AppColors.signColor,
                  ),
                ),
                SizedBox(width: Dimensions.width10),
                Obx(
                  () => Text(
                    countController.count.value.toString(),
                    style: TextStyle(
                        fontSize: Dimensions.textSizeLarge,
                        color: AppColors.textColor),
                  ),
                ),
                SizedBox(width: Dimensions.width10),
                GestureDetector(
                  onTap: () {
                    countController.increment();
                  },
                  child: const Icon(
                    Icons.add,
                    color: AppColors.signColor,
                  ),
                ),
              ]),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.width45,
                vertical: Dimensions.height15,
              ),
              decoration: BoxDecoration(
                color: Get.isDarkMode
                    ? AppColors.mainDarkColor
                    : AppColors.mainColor,
                borderRadius: BorderRadius.circular(Dimensions.radius20),
              ),
              child: Center(
                child: Text(
                  Constants.addToCart,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: Dimensions.textSizeLarge,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ItemCountController extends GetxController {
  var count = 1.obs;

  void increment() {
    if (count.value < 10) {
      count++;
    }
  }

  void decrement() {
    if (count.value > 1) {
      count--;
    }
  }
}
