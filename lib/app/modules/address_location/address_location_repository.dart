import 'package:foodfrenz/app/data/models/address_model.dart';
import 'package:foodfrenz/app/data/providers/cloud_firestore_provider.dart';

class AddressLocationRepository {
  final CloudFirestoreProvider cloudFirestoreProvider;

  AddressLocationRepository({required this.cloudFirestoreProvider});

  Future<AddressModel> getAddressLocation(String userId) async =>
      await cloudFirestoreProvider.getAddressLocation(userId);
}
