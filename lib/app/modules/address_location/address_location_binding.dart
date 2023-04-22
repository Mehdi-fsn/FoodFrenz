import 'package:foodfrenz/app/modules/address_location/address_location_controller.dart';
import 'package:foodfrenz/app/modules/address_location/address_location_repository.dart';
import 'package:get/get.dart';

class AddressLocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => AddressLocationRepository(cloudFirestoreProvider: Get.find()),
    );
    Get.lazyPut(() => AddressLocationController(
        addressLocationRepository: Get.find(), profileController: Get.find()));
  }
}
