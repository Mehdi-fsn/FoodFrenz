import 'package:foodfrenz/app/data/models/shopping_cart_item_model.dart';
import 'package:get/get.dart';

class ShoppingCartController extends GetxController {
  final _shoppingCart = <ShoppingCartItemModel>[].obs;

  List<ShoppingCartItemModel> get shoppingCart => _shoppingCart;

  void addProduct(ShoppingCartItemModel product) {
    _shoppingCart.add(product);
  }

  void removeProduct(ShoppingCartItemModel product) {
    _shoppingCart.remove(product);
  }

  void setQuantity(ShoppingCartItemModel product, int quantity) {
    product.quantity = quantity;
  }
}
