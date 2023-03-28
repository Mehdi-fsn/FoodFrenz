import 'package:foodfrenz/app/modules/home/home_controller.dart';
import 'package:foodfrenz/app/modules/home/home_repository.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeRepository(cloudFirestoreProvider: Get.find()));
    Get.put(HomeController(homeRepository: Get.find()));
  }
}
