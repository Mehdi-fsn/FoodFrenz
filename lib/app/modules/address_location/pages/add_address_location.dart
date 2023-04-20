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
                if (controller.textFieldHasFocus.value) {
                  controller.textFieldFocus.unfocus();
                } else {
                  controller.setCurrentLatLng(latLng);
                }
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
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: Dimensions.width10,
                    ),
                    child: Column(
                      children: [
                        TextField(
                          controller: controller.textAddressController,
                          focusNode: controller.textFieldFocus,
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
                        Obx(
                          () => controller.textFieldHasFocus.value
                              ? FutureBuilder(
                                  future: controller.searchAddress(
                                      controller.textAddressController.text),
                                  builder: (_,
                                      AsyncSnapshot<List<String>> snapshot) {
                                    switch (snapshot.connectionState) {
                                      case ConnectionState.waiting:
                                        return Center(
                                          child: SpinKitThreeBounce(
                                            color: Get.isDarkMode
                                                ? AppColors.mainDarkColor
                                                : AppColors.mainColor,
                                          ),
                                        );
                                      default:
                                        if (snapshot.hasError) {
                                          return const SizedBox.shrink();
                                        }
                                        return ListView.builder(
                                          itemBuilder: (_, index) {
                                            return ListTile(
                                              title:
                                                  Text(snapshot.data![index]),
                                            );
                                          },
                                        );
                                    }
                                  },
                                )
                              : const SizedBox.shrink(),
                        )
                      ],
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
