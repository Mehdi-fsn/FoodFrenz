import 'package:foodfrenz/app/modules/authentication/authentication_controller.dart';
import 'package:foodfrenz/app/modules/authentication/authentication_repository.dart';
import 'package:get/get.dart';

class AuthenticationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthenticationRepository(Get.find()));
    Get.lazyPut(() => AuthenticationController(Get.find()));
  }
}
