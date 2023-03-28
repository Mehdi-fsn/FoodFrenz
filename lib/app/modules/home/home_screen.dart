import 'package:flutter/material.dart';
import 'package:foodfrenz/app/core/constant/strings.dart';
import 'package:foodfrenz/app/core/theme/colors.dart';
import 'package:foodfrenz/app/core/utils/dimensions.dart';
import 'package:foodfrenz/app/data/models/carte_item_model.dart';
import 'package:foodfrenz/app/modules/home/home_controller.dart';
import 'package:foodfrenz/app/modules/home/widgets/recommended_items_view.dart';
import 'package:get/get.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                right: Dimensions.height20, left: Dimensions.height20),
            child: Container(
              margin: EdgeInsets.only(top: Dimensions.height45),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    Strings.foodFrenz,
                    style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? AppColors.mainDarkColor
                            : AppColors.mainColor,
                        fontSize: Dimensions.textSize30,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: Dimensions.height45,
                    height: Dimensions.height45,
                    child: FloatingActionButton(
                      onPressed: () {
                        Get.changeThemeMode(
                            Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);
                      },
                      backgroundColor: Get.isDarkMode
                          ? AppColors.mainDarkColor
                          : AppColors.mainColor,
                      child: Icon(
                          Get.isDarkMode
                              ? Icons.nightlight_outlined
                              : Icons.wb_sunny_outlined,
                          color: Colors.black87),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: Dimensions.height20),
          FutureBuilder(
            future: controller.recommendedItems,
            builder: (BuildContext context,
                AsyncSnapshot<List<CarteItemModel>> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                default:
                  return RecommendedItemsView(
                    recommendedItems: snapshot.data,
                  );
              }
            },
          ),
          SizedBox(height: Dimensions.height30),
          Padding(
            padding: EdgeInsets.only(left: Dimensions.height20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  Strings.popular,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: Dimensions.textSizeLarge,
                  ),
                ),
                SizedBox(width: Dimensions.width10),
                Container(
                  margin: const EdgeInsets.only(bottom: 3),
                  child: Text(
                    ".",
                    style: TextStyle(
                      color: Colors.black26,
                      fontSize: Dimensions.textSizeExtraLarge,
                    ),
                  ),
                ),
                SizedBox(width: Dimensions.width5),
                Container(
                  margin: const EdgeInsets.only(bottom: 2),
                  child: InkWell(
                    splashColor: AppColors.mainColor,
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    onTap: () {
                      //TODO: Navigate to All Items
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: Dimensions.width3, right: Dimensions.width3),
                      child: Text(
                        Strings.seeAll,
                        style: TextStyle(
                          color: Colors.black26,
                          fontSize: Dimensions.textSizeSmall,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
