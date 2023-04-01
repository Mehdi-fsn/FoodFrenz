import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodfrenz/app/core/constant/constants.dart';
import 'package:foodfrenz/app/core/theme/colors.dart';
import 'package:foodfrenz/app/core/utils/dimensions.dart';
import 'package:foodfrenz/app/core/utils/format.dart';
import 'package:foodfrenz/app/data/enums.dart';
import 'package:foodfrenz/app/data/models/carte_item_model.dart';
import 'package:foodfrenz/app/modules/home/home_controller.dart';
import 'package:foodfrenz/app/modules/home/widgets/components//simple_carte_item_card.dart';
import 'package:foodfrenz/app/widgets/app_icon_widget.dart';
import 'package:get/get.dart';

class AllCarteItemsPage extends StatelessWidget {
  AllCarteItemsPage({Key? key}) : super(key: key);

  final IndexController _indexController = Get.put(IndexController());

  final String appetizers =
      Format.formatCategoryCarteItemToString(CarteItemCategory.appetizer);
  final String mainCourses =
      Format.formatCategoryCarteItemToString(CarteItemCategory.mainCourse);
  final String desserts =
      Format.formatCategoryCarteItemToString(CarteItemCategory.dessert);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor:
                Get.isDarkMode ? AppColors.mainDarkColor : AppColors.mainColor,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(icon: Icons.arrow_back, onTap: () => Get.back()),
                Text(Constants.allMenu,
                    style: TextStyle(
                        color: Get.isDarkMode ? Colors.black : Colors.white)),
              ],
            ),
            automaticallyImplyLeading: false,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(Dimensions.height70),
              child: Container(
                decoration: BoxDecoration(
                  color: Get.theme.colorScheme.background,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20),
                    topRight: Radius.circular(Dimensions.radius20),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.width10,
                      vertical: Dimensions.height15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Obx(
                        () => buildButtonCategory(
                            carteItemCategory: CarteItemCategory.appetizer,
                            backgroundColor: AppColors.iconColor1,
                            isSelected: _indexController.selectedIndex ==
                                CarteItemCategory.appetizer.index),
                      ),
                      Obx(
                        () => buildButtonCategory(
                            carteItemCategory: CarteItemCategory.mainCourse,
                            backgroundColor: AppColors.mainColor,
                            isSelected: _indexController.selectedIndex ==
                                CarteItemCategory.mainCourse.index),
                      ),
                      Obx(
                        () => buildButtonCategory(
                            carteItemCategory: CarteItemCategory.dessert,
                            backgroundColor: AppColors.iconColor2,
                            isSelected: _indexController.selectedIndex ==
                                CarteItemCategory.dessert.index),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: CachedNetworkImage(
                imageUrl:
                    'https://www.allrecipes.com/thmb/sjKIoerfghFNEPf8wdh7FfLjHiw=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/how-to-plan-how-much-to-make-for-thanksgiving-shutterstock_493381651-2x1-1-d9dba94379b54162ad2ac4b8f84b6b3c.jpg',
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(
                  left: Dimensions.width10, right: Dimensions.width10),
              child: GetX(
                  init: Get.find<HomeController>(),
                  builder: (controller) {
                    return IndexedStack(
                        index: _indexController.selectedIndex,
                        children: [
                          buildListView(items: controller.appetizerItems),
                          buildListView(items: controller.mainCourseItems),
                          buildListView(items: controller.dessertItems),
                        ]);
                  }),
            ),
          )
        ],
      ),
    );
  }

  Widget buildListView({required List<CarteItemModel> items}) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (context, index) {
        return SimpleCarteItemCard(item: items[index]);
      },
    );
  }

  Widget buildButtonCategory(
      {required CarteItemCategory carteItemCategory,
      required Color backgroundColor,
      required bool isSelected}) {
    String txt = Format.formatCategoryCarteItemToString(carteItemCategory);
    return Container(
      decoration: BoxDecoration(
          color: isSelected ? backgroundColor : Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(Dimensions.radius20)),
          border: Border.all(color: backgroundColor)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.white24,
          borderRadius: BorderRadius.all(Radius.circular(Dimensions.radius20)),
          onTap: () {
            _indexController.selectedIndex = carteItemCategory.index;
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: Dimensions.height10, horizontal: Dimensions.width15),
            child: Center(
              child: Text(
                txt,
                style: TextStyle(
                  fontSize: Dimensions.textSizeSmall,
                  color: isSelected ? Colors.white : backgroundColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class IndexController extends GetxController {
  final _selectedIndex = 0.obs;

  int get selectedIndex => _selectedIndex.value;

  set selectedIndex(int value) => _selectedIndex.value = value;
}
