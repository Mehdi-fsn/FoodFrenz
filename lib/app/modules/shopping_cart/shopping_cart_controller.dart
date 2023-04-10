import 'package:foodfrenz/app/data/models/shopping_cart_item_model.dart';
import 'package:foodfrenz/app/modules/authentication/authentication_controller.dart';
import 'package:foodfrenz/app/modules/shopping_cart/shopping_cart_repository.dart';
import 'package:get/get.dart';

class ShoppingCartController extends GetxController {
  final ShoppingCartRepository shoppingCartRepository;

  ShoppingCartController({required this.shoppingCartRepository});

  final String userId = Get.find<AuthenticationController>().user!.uid;
  final shoppingCart = <ShoppingCartItemModel>[].obs;

  @override
  void onInit() {
    super.onInit();

    shoppingCart.bindStream(shoppingCartRepository.getCart(userId));
  }

  Future<void> addToCart(ShoppingCartItemModel item) async {
    await shoppingCartRepository.addToCart(userId, item);
  }
}
