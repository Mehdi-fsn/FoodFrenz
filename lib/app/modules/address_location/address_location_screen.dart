import 'package:flutter/material.dart';
import 'package:foodfrenz/app/core/theme/colors.dart';
import 'package:foodfrenz/app/core/utils/dimensions.dart';
import 'package:foodfrenz/app/data/enums.dart';
import 'package:foodfrenz/app/modules/address_location/address_location_controller.dart';
import 'package:foodfrenz/app/modules/address_location/pages/add_address_location.dart';
import 'package:foodfrenz/app/widgets/app_icon_widget.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddressLocationScreen extends GetView<AddressLocationController> {
  const AddressLocationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Obx(
              () => SizedBox(
                height: Dimensions.height350,
                width: Dimensions.screenWidth,
                child: GoogleMap(
                  initialCameraPosition: controller.currentPosition,
                  mapToolbarEnabled: false,
                  compassEnabled: false,
                  zoomControlsEnabled: false,
                  markers: controller.currentMarker.value != null
                      ? {controller.currentMarker.value!}
                      : {},
                  onMapCreated: (GoogleMapController mapController) {
                    controller.setMainMapController(mapController);
                  },
                ),
              ),
            ),
          ),
          Positioned(
            top: Dimensions.height40,
            left: Dimensions.width10,
            child: AppIcon(
              icon: Icons.arrow_back,
              onTap: () {
                Get.back();
              },
            ),
          ),
          Positioned(
            top: Dimensions.height350 - Dimensions.height15,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.only(
                top: Dimensions.height20,
                right: Dimensions.width20,
                left: Dimensions.width20,
                bottom: Dimensions.height5,
              ),
              decoration: BoxDecoration(
                color: Get.theme.colorScheme.background,
                borderRadius: BorderRadius.circular(Dimensions.radius20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _buildSelectorPredefinedAddress(
                          Icons.location_on_outlined,
                          AddressLocationType.current),
                      SizedBox(width: Dimensions.width20),
                      _buildSelectorPredefinedAddress(
                          Icons.home_outlined, AddressLocationType.home),
                      SizedBox(width: Dimensions.width20),
                      _buildSelectorPredefinedAddress(
                          Icons.work_outline, AddressLocationType.office),
                    ],
                  ),
                  SizedBox(height: Dimensions.height20),
                  Obx(() => SizedBox(
                        width: double.infinity,
                        child: _buildTextField(
                            controller.currentPlacemark.value?.street! ??
                                "No address set"),
                      )),
                  SizedBox(height: Dimensions.height10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Obx(() => Expanded(
                            child: _buildTextField(controller
                                    .currentPlacemark.value?.postalCode! ??
                                ""),
                          )),
                      SizedBox(width: Dimensions.width10),
                      Obx(() => Expanded(
                            child: _buildTextField(
                                controller.currentPlacemark.value?.locality! ??
                                    ""),
                          )),
                    ],
                  ),
                  SizedBox(height: Dimensions.height10),
                  Obx(() => _buildTextField(
                      controller.currentPlacemark.value?.country! ?? "null")),
                  SizedBox(height: Dimensions.height20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FloatingActionButton.extended(
                        onPressed: () {
                          Get.to(() => const AddAddressLocation());
                        },
                        label: Text(
                          'Add Address',
                          style: TextStyle(
                            color:
                                Get.isDarkMode ? Colors.black54 : Colors.white,
                          ),
                        ),
                        backgroundColor: Get.isDarkMode
                            ? AppColors.mainDarkColor
                            : AppColors.mainColor,
                      ),
                      FloatingActionButton.extended(
                        onPressed: () {
                          controller.setDeliveryAddress(
                              controller.currentLatLng.value);
                        },
                        label: Text(
                          'Save',
                          style: TextStyle(
                            color:
                                Get.isDarkMode ? Colors.black54 : Colors.white,
                          ),
                        ),
                        backgroundColor: Get.isDarkMode
                            ? AppColors.mainDarkColor
                            : AppColors.mainColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  //-- Region Widget Builder --//
  Widget _buildSelectorPredefinedAddress(
      IconData icon, AddressLocationType type) {
    return Obx(
      () => GestureDetector(
        onTap: () {
          final LatLng? latLng =
              controller.getLatLngBySelectedAddressLocationType(type);
          if (latLng != null) {
            controller.setCurrentLatLng(latLng);
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: Dimensions.height15,
            horizontal: Dimensions.width15,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              Dimensions.radius10,
            ),
            border: Border.all(
                color: controller.selectedAddressLocationType.value == type
                    ? Get.isDarkMode
                        ? AppColors.mainDarkColor
                        : AppColors.mainColor
                    : AppColors.paraColor),
          ),
          child: Icon(
            icon,
            color: AppColors.paraColor,
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String hintText) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.width15,
        vertical: Dimensions.height10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radius10),
        border: Border.all(
          color: AppColors.paraColor,
        ),
      ),
      child: Text(
        hintText,
        style: TextStyle(
          color: AppColors.paraColor,
          fontSize: Dimensions.textSizeMedium,
        ),
      ),
    );
  }
//-- End Region Widget Builder --//
}
