class UserInfoModel {
  final DateTime createdAt;
  final Map<String, dynamic> address;
  final int transactions;
  final num spending;

  UserInfoModel({
    required this.createdAt,
    required this.address,
    required this.transactions,
    required this.spending,
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> json,
      {required String userId}) {
    return UserInfoModel(
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

  UserInfoModel copyWith({
    DateTime? createdAt,
    Map<String, dynamic>? address,
    int? transactions,
    num? spending,
  }) {
    return UserInfoModel(
      createdAt: createdAt ?? this.createdAt,
      address: address ?? this.address,
      transactions: transactions ?? this.transactions,
      spending: spending ?? this.spending,
    );
  }
}
