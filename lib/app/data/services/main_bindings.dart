import 'package:foodfrenz/app/data/providers/cloud_firestore_provider.dart';
import 'package:foodfrenz/app/data/services/controllers/navigation_controller.dart';
import 'package:get/get.dart';

class MainBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NavigationController());
    Get.create(() => CloudFirestoreProvider());
  }
}
