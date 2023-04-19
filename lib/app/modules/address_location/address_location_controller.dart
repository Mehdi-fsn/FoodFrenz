import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:foodfrenz/app/core/utils/determine_geolocation.dart';
import 'package:foodfrenz/app/data/models/address_model.dart';
import 'package:foodfrenz/app/modules/address_location/address_location_repository.dart';
import 'package:foodfrenz/app/modules/authentication/authentication_controller.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddressLocationController extends GetxController {
  final AddressLocationRepository addressLocationRepository;

  AddressLocationController({required this.addressLocationRepository});

  final String userId = Get.find<AuthenticationController>().user!.uid;
  final Rx<AddressModel> _addressModel = AddressModel().obs;

  final Rx<LatLng> currentLatLng = const LatLng(43.607950, 3.886238).obs;
  CameraPosition currentPosition = const CameraPosition(
    target: LatLng(43.607950, 3.886238),
  );
  final Rx<Marker?> marker = Rx<Marker?>(null);

  final RxBool isLocationLoading = false.obs;

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
      currentPosition = CameraPosition(
        target: LatLng(latlng.latitude, latlng.longitude),
      );
      setMarker(latlng);
      setTextAddressController(await getPlaceMark(latlng));
      mapController.moveCamera(
        CameraUpdate.newCameraPosition(currentPosition),
      );
    });
  }

  //-- End Region Worker --//

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
  void setCurrentLatLng(LatLng latLng) {
    currentLatLng.value = latLng;
  }

  void setMarker(LatLng position) {
    marker.value = Marker(
      markerId: const MarkerId('marker'),
      position: LatLng(position.latitude, position.longitude),
      icon: BitmapDescriptor.defaultMarker,
    );
  }

  //-- End Region Setter --//

  //-- Region Various controllers--//
  late GoogleMapController mapController;

  void setMapController(GoogleMapController mapController) {
    this.mapController = mapController;
  }

  final TextEditingController textAddressController = TextEditingController();

  void setTextAddressController(Placemark placemark) {
    textAddressController.text =
        '${placemark.street!}, ${placemark.locality!}, ${placemark.postalCode!}, ${placemark.country!}';
  }
//-- End Region Various controllers--//
}
