class CartsItemModel {
  final String id;
  final String name;
  final String image;
  final int price;
  final int quantity;

  CartsItemModel({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.quantity,
  });

  factory CartsItemModel.fromJson(Map<String, dynamic> json) {
    return CartsItemModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      price: json['price'],
      quantity: json['quantity'],
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