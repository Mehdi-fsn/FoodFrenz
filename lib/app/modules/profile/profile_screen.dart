import 'package:flutter/material.dart';
import 'package:foodfrenz/app/modules/authentication/authentication_controller.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Get.find<AuthenticationController>().signOut();
          },
          child: const Text('Sign Out'),
        ),
      ),
    );
  }
}
