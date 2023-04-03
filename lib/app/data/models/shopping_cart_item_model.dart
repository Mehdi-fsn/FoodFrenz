import 'package:foodfrenz/app/data/models/carte_item_model.dart';

class ShoppingCartItemModel {
  final CarteItemModel item;
  int quantity;

  ShoppingCartItemModel({
    required this.item,
    required this.quantity,
  });

  void setQuantity(int quantity) {
    this.quantity = checkQuantity(quantity);
  }

  int checkQuantity(int quantity) {
    switch (quantity) {
      case 0:
        return 1;
      case 11:
        return 10;
      default:
        return quantity;
    }
  }
}
