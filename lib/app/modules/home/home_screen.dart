import 'package:flutter/material.dart';
import 'package:foodfrenz/app/core/constant/constants.dart';
import 'package:foodfrenz/app/core/theme/colors.dart';
import 'package:foodfrenz/app/core/utils/dimensions.dart';
import 'package:foodfrenz/app/data/models/carte_item_model.dart';
import 'package:foodfrenz/app/modules/home/home_controller.dart';
import 'package:foodfrenz/app/modules/home/widgets/views/popular_items_view.dart';
import 'package:foodfrenz/app/modules/home/widgets/views/recommended_items_view.dart';
import 'package:foodfrenz/app/routes/route_path.dart';
import 'package:get/get.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                      Constants.foodFrenz,
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
                          Get.changeThemeMode(Get.isDarkMode
                              ? ThemeMode.light
                              : ThemeMode.dark);
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
              SizedBox(height: Dimensions.height20),
              // Body
              FutureBuilder(
                future: Future.wait(
                    [controller.recommendedItems, controller.popularItems]),
                builder: (BuildContext context,
                    AsyncSnapshot<List<List<CarteItemModel>>> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return SizedBox(
                        height: Dimensions.screenHeight,
                        width: Dimensions.screenWidth,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    default:
                      return Column(
                        children: [
                          RecommendedItemsView(
                            recommendedItems: snapshot.data![0],
                          ),
                          SizedBox(height: Dimensions.height20),
                          _buildPopularText(),
                          PopularItemsView(
                            popularItems: snapshot.data![1],
                          ),
                        ],
                      );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPopularText() {
    return Padding(
      padding: EdgeInsets.only(left: Dimensions.height20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            Constants.popular,
            style: TextStyle(
              color: Get.theme.colorScheme.onBackground,
              fontSize: Dimensions.textSizeLarge,
            ),
          ),
          SizedBox(width: Dimensions.width10),
          Container(
            margin: const EdgeInsets.only(bottom: 3),
            child: Text(
              ".",
              style: TextStyle(
                color: Get.isDarkMode ? Colors.white : Colors.black26,
                fontSize: Dimensions.textSizeExtraLarge,
              ),
            ),
          ),
          SizedBox(width: Dimensions.width5),
          Container(
            margin: const EdgeInsets.only(bottom: 2),
            child: InkWell(
              focusColor: Colors.transparent,
              splashColor: Colors.transparent,
              borderRadius: BorderRadius.circular(Dimensions.radius20),
              onTap: () {
                Get.toNamed(
                    '${RoutePath.homeScreenPath}${RoutePath.allItemsPagePath}');
              },
              child: Padding(
                padding: EdgeInsets.only(
                    left: Dimensions.width3, right: Dimensions.width3),
                child: Text(
                  Constants.seeAll,
                  style: TextStyle(
                    color: Get.isDarkMode ? Colors.white : Colors.black26,
                    fontSize: Dimensions.textSizeSmall,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
