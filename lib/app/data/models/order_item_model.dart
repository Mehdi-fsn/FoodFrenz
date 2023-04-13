import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodfrenz/app/data/enums.dart';
import 'package:foodfrenz/app/data/models/shopping_cart_item_model.dart';

class OrderItemModel {
  final String id;
  final DateTime date;
  final StatusOrder status;
  final List<ShoppingCartItemModel> items;
  final num total;

  OrderItemModel({
    required this.id,
    required this.date,
    required this.status,
    required this.items,
    required this.total,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      id: json['id'] ?? 'TestId',
      date: (json['date'] as Timestamp).toDate(),
      status: StatusOrder.values[json['status']],
      items: (json['items'] as List<dynamic>)
          .map((item) => ShoppingCartItemModel.fromJson(item))
          .toList(),
      total: json['total'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': Timestamp.fromDate(date),
      'status': status.index,
      'items': items.map((item) => item.toJson()).toList(),
      'total': total,
    };
  }
}
