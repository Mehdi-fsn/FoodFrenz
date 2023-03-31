import 'package:flutter/material.dart';
import 'package:foodfrenz/app/core/theme/colors.dart';
import 'package:foodfrenz/app/core/utils/dimensions.dart';
import 'package:foodfrenz/app/core/utils/format.dart';
import 'package:foodfrenz/app/data/enums.dart';
import 'package:foodfrenz/app/modules/home/home_controller.dart';
import 'package:foodfrenz/app/modules/home/widgets/carte_item_card.dart';
import 'package:foodfrenz/app/widgets/chip_widget.dart';
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
      appBar: AppBar(
        title: Obx(
          () => Text(_indexController.selectedIndex == 0
              ? appetizers
              : _indexController.selectedIndex == 1
                  ? mainCourses
                  : desserts),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              left: Dimensions.width10, right: Dimensions.width10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildChipWidget(
                      label: appetizers, backgroundColor: AppColors.iconColor1),
                  _buildChipWidget(
                      label: mainCourses, backgroundColor: AppColors.mainColor),
                  _buildChipWidget(
                      label: desserts, backgroundColor: AppColors.iconColor2),
                ],
              ),
              SizedBox(height: Dimensions.height20),
              GetX(
                  init: Get.find<HomeController>(),
                  builder: (controller) {
                    return IndexedStack(
                        index: _indexController.selectedIndex,
                        children: [
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.appetizerItems.length,
                            itemBuilder: (context, index) {
                              return CarteItemCard(
                                  item: controller.appetizerItems[index]);
                            },
                          ),
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.mainCourseItems.length,
                            itemBuilder: (context, index) {
                              return CarteItemCard(
                                  item: controller.mainCourseItems[index]);
                            },
                          ),
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.dessertItems.length,
                            itemBuilder: (context, index) {
                              return CarteItemCard(
                                  item: controller.dessertItems[index]);
                            },
                          ),
                        ]);
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChipWidget(
      {required String label, required Color backgroundColor}) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            switch (label) {
              case "Appetizers":
                _indexController.selectedIndex = 0;
                break;
              case "Main Courses":
                _indexController.selectedIndex = 1;
                break;
              case "Desserts":
                _indexController.selectedIndex = 2;
                break;
            }
          },
          child: ChipWidget(label: label, backgroundColor: backgroundColor)),
    );
  }
}

class IndexController extends GetxController {
  final _selectedIndex = 0.obs;

  int get selectedIndex => _selectedIndex.value;

  set selectedIndex(int value) => _selectedIndex.value = value;
}
