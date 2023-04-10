import 'package:foodfrenz/app/data/models/carte_item_model.dart';

class ShoppingCartItemModel {
  final String id;
  final String name;
  final String image;
  final num price;
  final int quantity;

  ShoppingCartItemModel({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.quantity,
  });

  factory ShoppingCartItemModel.fromJson(Map<String, dynamic> json) {
    return ShoppingCartItemModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      price: json['price'],
      quantity: json['quantity'],
    );
  }

  factory ShoppingCartItemModel.fromCarteItemModel(
      CarteItemModel item, int quantity) {
    return ShoppingCartItemModel(
      id: item.id,
      name: item.name,
      image: item.image,
      price: item.price,
      quantity: quantity,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'price': price,
      'quantity': quantity,
    };
  }
}
