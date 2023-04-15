class UserModel {
  final DateTime createdAt;
  final Map<String, dynamic> address;
  final int transactions;
  final num spending;

  UserModel({
    required this.createdAt,
    required this.address,
    required this.transactions,
    required this.spending,
  });

  factory UserModel.fromJson(Map<String, dynamic> json,
      {required String userId}) {
    return UserModel(
      createdAt: json['createdAt'].toDate(),
      address: json['address'],
      transactions: json['transactions'],
      spending: json['spending'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'createdAt': createdAt,
      'address': address,
      'transactions': transactions,
      'spending': spending,
    };
  }
}
