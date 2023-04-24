import 'package:foodfrenz/app/modules/profile/profile_controller.dart';
import 'package:foodfrenz/app/modules/profile/profile_repository.dart';
import 'package:get/get.dart';

class ProfileBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => ProfileRepository(cloudFirestoreProvider: Get.find()),
    );
    Get.lazyPut(
      () => ProfileController(profileRepository: Get.find()),
    );
  }
}
