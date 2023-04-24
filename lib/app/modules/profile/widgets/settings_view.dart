import 'package:flutter/material.dart';
import 'package:foodfrenz/app/core/utils/dimensions.dart';
import 'package:foodfrenz/app/modules/address_location/address_location_binding.dart';
import 'package:foodfrenz/app/modules/address_location/address_location_screen.dart';
import 'package:foodfrenz/app/modules/authentication/authentication_controller.dart';
import 'package:foodfrenz/app/modules/profile/pages/informations_page.dart';
import 'package:foodfrenz/app/modules/profile/pages/payment_settings_page.dart';
import 'package:foodfrenz/app/modules/profile/profile_controller.dart';
import 'package:get/get.dart';

class SettingsView extends GetView<ProfileController> {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.info_outline),
          title: const Text('Informations'),
          contentPadding: EdgeInsets.symmetric(
              vertical: Dimensions.height5, horizontal: Dimensions.width20),
          onTap: () {
            Get.dialog(
              InformationsPage(),
              useSafeArea: false,
              barrierDismissible: false,
            );
          },
        ),
        Divider(
          height: 0,
          thickness: 1,
          indent: Get.width * 0.20,
        ),
        ListTile(
          leading: const Icon(Icons.location_on),
          title: const Text('Delivery Address'),
          contentPadding: EdgeInsets.symmetric(
              vertical: Dimensions.height5, horizontal: Dimensions.width20),
          onTap: () {
            Get.to(
              () => const AddressLocationScreen(),
              binding: AddressLocationBinding(),
            );
          },
        ),
        Divider(
          height: 0,
          thickness: 1,
          indent: Get.width * 0.20,
        ),
        ListTile(
          leading: const Icon(Icons.payment_outlined),
          title: const Text('Payment Settings'),
          contentPadding: EdgeInsets.symmetric(
              vertical: Dimensions.height5, horizontal: Dimensions.width20),
          onTap: () {
            Get.dialog(
              const PaymentSettingsPage(),
              useSafeArea: false,
              barrierDismissible: false,
            );
          },
        ),
        Divider(
          height: 0,
          thickness: 1,
          indent: Get.width * 0.20,
        ),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('Logout'),
          contentPadding: EdgeInsets.symmetric(
              vertical: Dimensions.height5, horizontal: Dimensions.width20),
          onTap: () {
            Get.find<AuthenticationController>().signOut();
          },
        )
      ],
    );
  }
}
