import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:foodfrenz/app/core/theme/colors.dart';
import 'package:foodfrenz/app/core/utils/dimensions.dart';
import 'package:foodfrenz/app/modules/address_location/address_location_controller.dart';
import 'package:foodfrenz/app/widgets/app_icon_widget.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddAddressLocation extends GetView<AddressLocationController> {
  const AddAddressLocation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Obx(
            () => GoogleMap(
              initialCameraPosition: controller.currentPosition,
              myLocationButtonEnabled: controller.isLocationLoading.value,
              mapToolbarEnabled: false,
              compassEnabled: false,
              zoomControlsEnabled: false,
              markers: controller.currentMarker.value != null
                  ? {controller.currentMarker.value!}
                  : {},
              onMapCreated: (GoogleMapController mapController) {
                controller.setMapController(mapController);
              },
              onTap: (LatLng latLng) {
                controller.setCurrentLatLng(latLng);
              },
            ),
          ),
          Positioned(
            top: Dimensions.height40,
            left: Dimensions.width10,
            right: Dimensions.width10,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(
                  icon: Icons.arrow_back,
                  onTap: () {
                    Get.back();
                  },
                ),
                Row(
                  children: [
                    AppIcon(
                      icon: Icons.location_searching_outlined,
                      onTap: () {
                        controller.getCurrentLocation();
                      },
                    ),
                    SizedBox(width: Dimensions.width10),
                    AppIcon(
                      icon: Icons.search,
                      onTap: () {
                        controller.launchSearchAddress(context);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Obx(() => controller.isLocationLoading.value
              ? Center(
                  child: SpinKitSquareCircle(
                      color: Get.isDarkMode
                          ? AppColors.mainDarkColor
                          : AppColors.mainColor),
                )
              : const SizedBox.shrink()),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(
                  bottom: Dimensions.height20,
                  left: Dimensions.width10,
                  right: Dimensions.width10),
              child: FloatingActionButton.extended(
                onPressed: () {},
                label: const Text('Add address'),
                icon: const Icon(Icons.add),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
