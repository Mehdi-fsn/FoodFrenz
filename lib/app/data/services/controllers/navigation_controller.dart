import 'package:flutter/material.dart';
import 'package:foodfrenz/app/modules/home/home_binding.dart';
import 'package:foodfrenz/app/modules/home/home_screen.dart';
import 'package:foodfrenz/app/modules/order_history/orders_history_binding.dart';
import 'package:foodfrenz/app/modules/order_history/orders_history_screen.dart';
import 'package:foodfrenz/app/modules/profile/profile_screen.dart';
import 'package:foodfrenz/app/modules/shopping_cart/shopping_cart_screen.dart';
import 'package:foodfrenz/app/routes/route_path.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  final _currentIndex = 0.obs;

  int get currentIndex => _currentIndex.value;

  void changePage(int index) {
    if (index != _currentIndex.value) {
      _currentIndex.value = index;
      Get.toNamed(RoutePath.pages[index], id: 1);
    }
  }

  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePath.homeScreenPath:
        return GetPageRoute(
          settings: settings,
          page: () => const HomeScreen(),
          binding: HomeBinding(),
        );
      case RoutePath.orderScreenPath:
        return GetPageRoute(
          settings: settings,
          page: () => const OrdersHistoryScreen(),
          binding: OrdersHistoryBinding(),
        );
      case RoutePath.shoppingCartScreenPath:
        return GetPageRoute(
          settings: settings,
          page: () => const ShoppingCartScreen(),
        );
      case RoutePath.profileScreenPath:
        return GetPageRoute(
          settings: settings,
          page: () => const ProfileScreen(),
        );
      default:
        return GetPageRoute(
          settings: settings,
          page: () => const Scaffold(
            body: Center(
              child: Text('Page not found'),
            ),
          ),
        );
    }
  }
}
