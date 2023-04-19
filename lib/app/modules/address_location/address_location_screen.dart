import 'package:flutter/material.dart';
import 'package:foodfrenz/app/core/utils/dimensions.dart';
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
          // Maps
          Positioned(
            left: 0,
            top: 0,
            child: SizedBox(
              height: Dimensions.height350,
              width: Dimensions.screenWidth,
              child: const GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(43.607950, 3.886238),
                ),
              ),
            ),
          ),
          // Back Button and Cart Icon
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
          // Item Details
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
                child: Center(
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      Get.to(
                        const AddAddressLocation(),
                      );
                    },
                    label: const Text('Add Address'),
                    icon: const Icon(Icons.add),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
