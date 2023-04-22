import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddressModel {
  LatLng? currentLocation;
  LatLng? homeLocation;
  LatLng? officeLocation;

  AddressModel({
    this.currentLocation,
    this.homeLocation,
    this.officeLocation,
  });

  factory AddressModel.fromJson(Map<String, dynamic> map) {
    return AddressModel(
      currentLocation: LatLng.fromJson(map["currentLocation"]),
      homeLocation: LatLng.fromJson(map["homeLocation"]),
      officeLocation: LatLng.fromJson(map["officeLocation"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "currentLocation": latLngToList(currentLocation),
      "homeLocation": latLngToList(homeLocation),
      "officeLocation": latLngToList(officeLocation),
    };
  }

  List<double> latLngToList(LatLng? latLng) {
    if (latLng == null) return [];
    return [latLng.latitude, latLng.longitude];
  }

  AddressModel copyWith({
    LatLng? currentLocation,
    LatLng? homeLocation,
    LatLng? officeLocation,
  }) {
    return AddressModel(
      currentLocation: currentLocation ?? this.currentLocation,
      homeLocation: homeLocation ?? this.homeLocation,
      officeLocation: officeLocation ?? this.officeLocation,
    );
  }
}
