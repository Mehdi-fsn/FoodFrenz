import 'package:foodfrenz/app/modules/shopping_cart/shopping_cart_controller.dart';
import 'package:get/get.dart';

class ShoppingCartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ShoppingCartController());
  }
}
