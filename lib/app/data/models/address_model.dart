import 'package:geolocator/geolocator.dart';

class AddressModel {
  Position? homeLocation;
  Position? officeLocation;

  AddressModel({
    this.homeLocation,
    this.officeLocation,
  });

  factory AddressModel.fromJson(Map<String, Map<String, dynamic>> map) {
    return AddressModel(
      homeLocation: map['homeLocation'] != null
          ? Position(
              latitude: map["homeLocation"]!["latitude"],
              longitude: map["homeLocation"]!["longitude"],
              timestamp: map["homeLocation"]!["timestamp"],
              accuracy: 1,
              altitude: 1,
              heading: 1,
              speed: 1,
              speedAccuracy: 1,
            )
          : null,
      officeLocation: map['officeLocation'] != null
          ? Position(
              latitude: map["officeLocation"]!["latitude"],
              longitude: map["officeLocation"]!["longitude"],
              timestamp: map["officeLocation"]!["timestamp"],
              accuracy: 1,
              altitude: 1,
              heading: 1,
              speed: 1,
              speedAccuracy: 1,
            )
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
