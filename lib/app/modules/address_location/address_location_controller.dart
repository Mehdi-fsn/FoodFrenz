import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:foodfrenz/app/core/utils/determine_geolocation.dart';
import 'package:foodfrenz/app/data/models/address_model.dart';
import 'package:foodfrenz/app/modules/address_location/address_location_repository.dart';
import 'package:foodfrenz/app/modules/authentication/authentication_controller.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart' as gws;

class AddressLocationController extends GetxController {
  final AddressLocationRepository addressLocationRepository;

  AddressLocationController({required this.addressLocationRepository});

  final String userId = Get.find<AuthenticationController>().user!.uid;
  final Rx<AddressModel> _addressModel = AddressModel().obs;

  final Rx<LatLng> currentLatLng = const LatLng(43.607950, 3.886238).obs;
  CameraPosition currentPosition = const CameraPosition(
    target: LatLng(43.607950, 3.886238),
    zoom: 16.0,
  );
  final Rx<Marker?> currentMarker = Rx<Marker?>(null);
  final Rx<Placemark?> currentPlacemark = Rx<Placemark?>(null);

  final RxBool isLocationLoading = false.obs;

  final String kGoogleApiKey = "AIzaSyBAceSg1tCTiK2W45dO9W2sjA924uT2oh8";

  @override
  void onReady() async {
    init();
    workerPositionChanged();
    super.onReady();
  }

  //-- Region Init --//
  void init() async {
    _addressModel.value =
        await addressLocationRepository.getAddressLocation(userId);
    ;
  }

  //-- End Region Init --//

  //-- Region Worker --//
  void workerPositionChanged() {
    ever(currentLatLng, (latlng) async {
      setCurrentPosition(CameraPosition(
        target: LatLng(latlng.latitude, latlng.longitude),
        zoom: 16.0,
      ));
      setCurrentMarker(latlng);
      setCurrentPlacemark(await getPlaceMark(latlng));
      moveMapControllerToAddress(currentPosition);
    });
  }

  //-- End Region Worker --//

  //-- Region Methods --//
  String convertLocationToAddress(Placemark placemark) {
    return '${placemark.street!}, ${placemark.locality!}, ${placemark.postalCode!}, ${placemark.country!}';
  }

  void moveMapControllerToAddress(CameraPosition cameraPosition) async {
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(cameraPosition),
    );
  }

  void launchSearchAddress(BuildContext context) async {
    gws.Prediction? p = await PlacesAutocomplete.show(
      context: context,
      apiKey: kGoogleApiKey,
      language: "fr",
      decoration: InputDecoration(
        hintText: 'Search',
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
      ),
      components: [gws.Component(gws.Component.country, "fr")],
    );

    if (p != null) {
      List<Location> location = await locationFromAddress(p.description!);
      setCurrentLatLng(LatLng(location[0].latitude, location[0].longitude));
    }
  }

  //-- End Region Methods --//

  //-- Region Getter --//
  Future<void> getCurrentLocation() async {
    isLocationLoading.value = true;
    Position? currentLocation =
        await determineCurrentLocation().catchError((error) {
      Get.snackbar("Error", error.toString());
      return null;
    });
    isLocationLoading.value = false;
    if (currentLocation == null) return;

    setCurrentLatLng(
        LatLng(currentLocation.latitude, currentLocation.longitude));
  }

  Future<Placemark> getPlaceMark(LatLng latlng) async {
    List<Placemark> listPlacemark =
        await placemarkFromCoordinates(latlng.latitude, latlng.longitude);
    return listPlacemark[0];
  }

  //-- End Region Getter --//

  //-- Region Setter --//
  void setCurrentPosition(CameraPosition cameraPosition) {
    currentPosition = cameraPosition;
  }

  void setCurrentLatLng(LatLng latLng) {
    currentLatLng.value = latLng;
  }

  void setCurrentMarker(LatLng position) {
    currentMarker.value = Marker(
      markerId: const MarkerId('marker'),
      position: LatLng(position.latitude, position.longitude),
      icon: BitmapDescriptor.defaultMarker,
    );
  }

  void setCurrentPlacemark(Placemark placemark) {
    currentPlacemark.value = placemark;
  }

  //-- End Region Setter --//

  //-- Region Various controllers--//
  late GoogleMapController mapController;

  void setMapController(GoogleMapController mapController) {
    this.mapController = mapController;
  }
//-- End Region Various controllers--//
}
