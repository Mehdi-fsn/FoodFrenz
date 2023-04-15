import 'package:flutter/material.dart';
import 'package:foodfrenz/app/core/utils/dimensions.dart';
import 'package:foodfrenz/app/modules/authentication/authentication_controller.dart';
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
          onTap: () {},
        ),
        Divider(
          height: 0,
          thickness: 1,
          indent: Get.width * 0.20,
        ),
        ListTile(
          leading: const Icon(Icons.location_on),
          title: const Text('Address localisation'),
          contentPadding: EdgeInsets.symmetric(
              vertical: Dimensions.height5, horizontal: Dimensions.width20),
          onTap: () {},
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
          onTap: () {},
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
