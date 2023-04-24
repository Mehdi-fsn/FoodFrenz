import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:foodfrenz/app/core/utils/determine_geolocation.dart';
import 'package:foodfrenz/app/data/enums.dart';
import 'package:foodfrenz/app/data/models/address_model.dart';
import 'package:foodfrenz/app/modules/address_location/address_location_repository.dart';
import 'package:foodfrenz/app/modules/authentication/authentication_controller.dart';
import 'package:foodfrenz/app/modules/profile/profile_controller.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart' as gws;

class AddressLocationController extends GetxController {
  final AddressLocationRepository addressLocationRepository;
  final ProfileController profileController;

  AddressLocationController(
      {required this.addressLocationRepository,
      required this.profileController});

  final String userId = Get.find<AuthenticationController>().user!.uid;
  final Rx<AddressModel> addressModel = AddressModel().obs;

  final Rx<LatLng> currentLatLng = const LatLng(43.607950, 3.886238).obs;
  CameraPosition currentPosition = const CameraPosition(
    target: LatLng(43.607950, 3.886238),
    zoom: 16.0,
  );
  final Rx<Marker?> currentMarker = Rx<Marker?>(null);
  final Rx<Placemark?> currentPlacemark = Rx<Placemark?>(null);

  final RxBool isLocationLoading = false.obs;
  final Rx<AddressLocationType> selectedAddressLocationType =
      AddressLocationType.current.obs;

  final String kGoogleApiKey = "AIzaSyBAceSg1tCTiK2W45dO9W2sjA924uT2oh8";

  @override
  void onInit() async {
    init();
    workerPositionChanged();
    super.onInit();
  }

  //-- Region Init --//
  void init() async {
    addressModel.value = profileController.userInfo.value.address;
    if (addressModel.value.currentLocation != null) {
      onCurrentLatLngChanged(addressModel.value.currentLocation!);
    } else {
      onCurrentLatLngChanged(currentLatLng.value);
    }
  }

  //-- End Region Init --//

  //-- Region Worker --//
  void workerPositionChanged() {
    ever(currentLatLng, (latlng) async {
      onCurrentLatLngChanged(latlng);
    });
  }

  //-- End Region Worker --//

  //-- Region Methods --//
  void onCurrentLatLngChanged(LatLng latlng) async {
    setCurrentPosition(CameraPosition(
      target: LatLng(latlng.latitude, latlng.longitude),
      zoom: 16.0,
    ));
    setCurrentMarker(latlng);
    setCurrentPlacemark(await getPlaceMark(latlng));
    moveMapControllerToAddress(currentPosition);
  }

  void moveMapControllerToAddress(CameraPosition cameraPosition) async {
    try {
      mainMapController.animateCamera(
        CameraUpdate.newCameraPosition(cameraPosition),
      );
      secondMapController.animateCamera(
        CameraUpdate.newCameraPosition(cameraPosition),
      );
    } catch (_) {
      print("Map is not initialized yet");
    }
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

  LatLng? getLatLngBySelectedAddressLocationType(AddressLocationType type) {
    switch (type) {
      case AddressLocationType.current:
        if (addressModel.value.currentLocation != null) {
          setSelectedAddressLocationType(type);
          return addressModel.value.currentLocation!;
        } else {
          Get.snackbar("Error", "No current location defined");
          return null;
        }
      case AddressLocationType.home:
        if (addressModel.value.homeLocation != null) {
          setSelectedAddressLocationType(type);
          return addressModel.value.homeLocation!;
        } else {
          Get.snackbar("Error", "No home location defined");
          return null;
        }
      case AddressLocationType.office:
        if (addressModel.value.officeLocation != null) {
          setSelectedAddressLocationType(type);
          return addressModel.value.officeLocation!;
        } else {
          Get.snackbar("Error", "No office location defined");
          return null;
        }
      default:
        return currentLatLng.value;
    }
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

  void setSelectedAddressLocationType(AddressLocationType type) {
    selectedAddressLocationType.value = type;
  }

  void setDeliveryAddress(LatLng? latLng) {
    profileController.setDeliveryAddress(latLng);
  }

  void addAddressLocation(
      {LatLng? current, LatLng? home, LatLng? office}) async {
    addressModel.value = addressModel.value.copyWith(
      currentLocation: current,
      homeLocation: home,
      officeLocation: office,
    );
    await addressLocationRepository.setAddressLocation(
        userId, addressModel.value);
  }

  //-- End Region Setter --//

  //-- Region Various controllers--//
  late GoogleMapController mainMapController;
  late GoogleMapController secondMapController;

  void setMainMapController(GoogleMapController mapController) {
    mainMapController = mapController;
  }

  void setSecondMapController(GoogleMapController mapController) {
    secondMapController = mapController;
  }
//-- End Region Various controllers--//
}
