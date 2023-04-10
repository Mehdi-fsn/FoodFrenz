import 'package:flutter/material.dart';
import 'package:foodfrenz/app/core/constant/constants.dart';
import 'package:foodfrenz/app/core/theme/colors.dart';
import 'package:foodfrenz/app/data/services/controllers/navigation_controller.dart';
import 'package:foodfrenz/app/routes/route_path.dart';
import 'package:get/get.dart';

class MainScreen extends GetView<NavigationController> {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigator(
        key: Get.nestedKey(1),
        initialRoute: RoutePath.homeScreenPath,
        onGenerateRoute: controller.onGenerateRoute,
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
            backgroundColor: Get.theme.colorScheme.background,
            selectedItemColor:
                Get.isDarkMode ? AppColors.mainDarkColor : AppColors.mainColor,
            unselectedItemColor:
                Get.theme.colorScheme.onBackground.withOpacity(0.5),
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: Constants.home,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.receipt_long_outlined),
                label: Constants.order,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_outlined),
                label: Constants.cart,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: Constants.profile,
              ),
            ],
            currentIndex: controller.currentIndex,
            onTap: (index) {
              controller.changePage(index);
            }),
      ),
    );
  }
}
