import 'package:geocoding/geocoding.dart';

class AddressModel {
  Location? homeLocation;
  Location? officeLocation;

  AddressModel({
    this.homeLocation,
    this.officeLocation,
  });

  factory AddressModel.fromJson(Map<String, Map<String, dynamic>> map) {
    return AddressModel(
      homeLocation: map['homeLocation'] != null
          ? Location(
              latitude: map["homeLocation"]!["latitude"],
              longitude: map["homeLocation"]!["longitude"],
              timestamp: map["homeLocation"]!["timestamp"])
          : null,
      officeLocation: map['officeLocation'] != null
          ? Location(
              latitude: map["officeLocation"]!["latitude"],
              longitude: map["officeLocation"]!["longitude"],
              timestamp: map["officeLocation"]!["timestamp"])
          : null,
    );
  }

  Map<String, Map<String, dynamic>> toJson() {
    return {
      if (homeLocation != null) "homeLocation": homeLocation!.toJson(),
      if (officeLocation != null) "officeLocation": officeLocation!.toJson(),
    };
  }
}
