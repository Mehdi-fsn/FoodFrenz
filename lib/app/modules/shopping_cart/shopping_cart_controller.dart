import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodfrenz/app/core/utils/generate_random_order_id.dart';
import 'package:foodfrenz/app/data/enums.dart';
import 'package:foodfrenz/app/data/models/order_item_model.dart';
import 'package:foodfrenz/app/data/models/shopping_cart_item_model.dart';
import 'package:foodfrenz/app/modules/authentication/authentication_controller.dart';
import 'package:foodfrenz/app/modules/shopping_cart/shopping_cart_repository.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';

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

  Future<void> removedItemInCart(ShoppingCartItemModel item) async {
    await shoppingCartRepository.removedItemInCart(userId, item);
  }

  void updateItemQuantity(ShoppingCartItemModel item, int newQuantity) {
    if (newQuantity > 10) {
      return;
    } else if (newQuantity == 0) {
      removedItemInCart(item);
    } else {
      var itemIndex = shoppingCart.indexWhere((i) => i.id == item.id);
      shoppingCart[itemIndex] = item.copyWith(quantity: newQuantity);
      item.quantity = newQuantity;
      _updateItemQuantityDebounced(item);
    }
  }

  final _debouncer = Debouncer(delay: const Duration(seconds: 3));

  void _updateItemQuantityDebounced(ShoppingCartItemModel item) {
    _debouncer.call(() async =>
        await shoppingCartRepository.updateItemQuantity(userId, item));
  }

  String get totalPrice => shoppingCart
      .fold(
          0.0,
          (previousValue, element) =>
              previousValue + (element.price * element.quantity))
      .toStringAsFixed(2);

  String get totalItems => shoppingCart
      .fold(0, (previousValue, element) => previousValue + element.quantity)
      .toString();

  Future<void> placeOrder() async {
    final OrderItemModel item = OrderItemModel(
      id: generateRandomOrderId(),
      date: Timestamp.now().toDate(),
      status: StatusOrder.pending,
      items: shoppingCart,
      total: double.parse(totalPrice),
    );
    await shoppingCartRepository.placeOrder(userId, item);
  }
}
