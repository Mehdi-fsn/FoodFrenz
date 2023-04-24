import 'package:foodfrenz/app/data/services/controllers/navigation_controller.dart';
import 'package:foodfrenz/app/modules/profile/profile_binding.dart';
import 'package:foodfrenz/app/modules/shopping_cart/shopping_cart_binding.dart';
import 'package:get/get.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NavigationController());
    ProfileBindings().dependencies();
    ShoppingCartBinding().dependencies();
  }
}
