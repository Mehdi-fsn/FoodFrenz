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
              markers: controller.marker.value != null
                  ? {controller.marker.value!}
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(
                  icon: Icons.arrow_back,
                  onTap: () {
                    Get.back();
                  },
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: Dimensions.width10,
                    ),
                    child: TextField(
                      controller: controller.textAddressController,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        hintText: 'Search',
                        hintStyle: TextStyle(
                          color: Get.isDarkMode
                              ? AppColors.mainDarkColor
                              : AppColors.mainColor,
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Get.isDarkMode
                              ? AppColors.mainDarkColor
                              : AppColors.mainColor,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Color(0xFFfcf4e4),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Color(0xFFfcf4e4),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                ),
                AppIcon(
                  icon: Icons.location_searching_outlined,
                  onTap: () {
                    controller.getCurrentLocation();
                  },
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
              margin: EdgeInsets.only(bottom: Dimensions.height20),
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
