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
    zoom: 16.0,
  );
  final Rx<Marker?> currentMarker = Rx<Marker?>(null);
  final Rx<Placemark?> currentPlacemark = Rx<Placemark?>(null);

  final RxBool isLocationLoading = false.obs;

  @override
  void onReady() async {
    init();
    workerPositionChanged();
    workerPlacemarkChanged();
    onFocusChange();
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

  void workerPlacemarkChanged() {
    ever(currentPlacemark, (placemark) async {
      if (placemark == null) return;
      setTextAddressController(placemark);
    });
  }

  //-- End Region Worker --//

  //-- Region Methods --//
  Future<List<String>> searchAddress(String searchQuery) async {
    try {
      List<Location> locations = await locationFromAddress(searchQuery);
      List<Future<String>> addressesFuture = locations.map((location) async {
        final latlng = LatLng(location.latitude, location.longitude);
        final placemark = await getPlaceMark(latlng);
        return convertLocationToAddress(placemark);
      }).toList();

      return await Future.wait(addressesFuture);
    } catch (_) {
      Get.snackbar("Error", "Error while searching address");
      return [];
    }
  }

  String convertLocationToAddress(Placemark placemark) {
    return '${placemark.street!}, ${placemark.locality!}, ${placemark.postalCode!}, ${placemark.country!}';
  }

  void moveMapControllerToAddress(CameraPosition cameraPosition) async {
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(cameraPosition),
    );
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

  final TextEditingController textAddressController = TextEditingController();
  final FocusNode textFieldFocus = FocusNode();
  final Rx<bool> textFieldHasFocus = false.obs;

  void setTextAddressController(Placemark placemark) {
    textAddressController.text = convertLocationToAddress(placemark);
  }

  void onFocusChange() {
    textFieldFocus.addListener(() {
      textFieldHasFocus.value = textFieldFocus.hasFocus;
    });
  }
//-- End Region Various controllers--//
}
