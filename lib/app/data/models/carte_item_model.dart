class CarteItemModel {
  final String name;
  final String image;
  final String description;
  final num price;
  final num notes;
  final int comments;
  final num distance;
  final String origin;

  CarteItemModel({
    required this.name,
    required this.image,
    required this.description,
    required this.price,
    required this.notes,
    required this.comments,
    required this.distance,
    required this.origin,
  });

  factory CarteItemModel.fromJson(Map<String, dynamic> map) {
    return CarteItemModel(
      name: map['name'],
      image: map['image'],
      description: map['description'],
      price: map['price'],
      notes: map['notes'],
      comments: map['comments'],
      distance: map['distance'],
      origin: map['origin'],
    );
  }
}
