import 'package:flutter/material.dart';
import 'package:foodfrenz/app/modules/authentication/authentication_controller.dart';
import 'package:foodfrenz/app/routes/route_path.dart';
import 'package:get/get.dart';

class AuthenticationMiddleware extends GetMiddleware {
  final AuthenticationController _authenticationController = Get.find();

  @override
  RouteSettings? redirect(String? route) {
    if (_authenticationController.user != null) {
      return null;
    } else {
      return const RouteSettings(name: RoutePath.authenticationScreenPath);
    }
  }
}
