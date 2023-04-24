import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:foodfrenz/app/core/theme/colors.dart';
import 'package:foodfrenz/app/core/utils/dimensions.dart';
import 'package:foodfrenz/app/data/enums.dart';
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
              mapToolbarEnabled: false,
              compassEnabled: false,
              zoomControlsEnabled: false,
              markers: controller.currentMarker.value != null
                  ? {controller.currentMarker.value!}
                  : {},
              onMapCreated: (GoogleMapController mapController) {
                controller.setSecondMapController(mapController);
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
                onPressed: () {
                  Get.dialog(const RadioDialogConfirmAddress());
                },
                label: Text(
                  'Add address',
                  style: TextStyle(
                    color: Get.isDarkMode ? Colors.black54 : Colors.white,
                  ),
                ),
                icon: Icon(
                  Icons.add,
                  color: Get.isDarkMode ? Colors.black54 : Colors.white,
                ),
                backgroundColor: Get.isDarkMode
                    ? AppColors.mainDarkColor
                    : AppColors.mainColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RadioDialogConfirmAddress extends StatefulWidget {
  const RadioDialogConfirmAddress({Key? key}) : super(key: key);

  @override
  State<RadioDialogConfirmAddress> createState() =>
      _RadioDialogConfirmAddressState();
}

class _RadioDialogConfirmAddressState extends State<RadioDialogConfirmAddress> {
  final AddressLocationController controller = Get.find();

  AddressLocationType selectedAddressLocationType = AddressLocationType.current;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Confirm address :"),
      content: Text(
          '${controller.currentPlacemark.value!.street!}, ${controller.currentPlacemark.value!.locality!}, ${controller.currentPlacemark.value!.postalCode!}'),
      actions: [
        ListTile(
          title: const Text('Current'),
          leading: Radio(
            value: AddressLocationType.current,
            groupValue: selectedAddressLocationType,
            onChanged: (value) {
              setState(() {
                selectedAddressLocationType = value!;
                controller.setSelectedAddressLocationType(value);
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Home'),
          leading: Radio(
            value: AddressLocationType.home,
            groupValue: selectedAddressLocationType,
            onChanged: (value) {
              setState(() {
                selectedAddressLocationType = value!;
                controller.setSelectedAddressLocationType(value);
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Office'),
          leading: Radio(
            value: AddressLocationType.office,
            groupValue: selectedAddressLocationType,
            onChanged: (value) {
              setState(() {
                selectedAddressLocationType = value!;
                controller.setSelectedAddressLocationType(value);
              });
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                switch (selectedAddressLocationType) {
                  case AddressLocationType.current:
                    controller.addAddressLocation(
                        current: controller.currentLatLng.value);
                    break;
                  case AddressLocationType.home:
                    controller.addAddressLocation(
                        home: controller.currentLatLng.value,
                        current: controller.currentLatLng.value);
                    break;
                  case AddressLocationType.office:
                    controller.addAddressLocation(
                        office: controller.currentLatLng.value,
                        current: controller.currentLatLng.value);
                    break;
                }
                Get.back();
                Get.back();
              },
              child: const Text('Add'),
            ),
          ],
        ),
      ],
    );
  }
}
