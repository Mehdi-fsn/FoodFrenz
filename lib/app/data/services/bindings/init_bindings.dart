import 'package:foodfrenz/app/data/providers/authentication_provider.dart';
import 'package:foodfrenz/app/data/providers/cloud_firestore_provider.dart';
import 'package:foodfrenz/app/modules/authentication/authentication_binding.dart';
import 'package:get/get.dart';

Future<void> initBindings() async {
  // Provider
  Get.put(CloudFirestoreProvider(), permanent: true);
  Get.put(AuthenticationProvider(), permanent: true);

  // Authentication
  AuthenticationBinding().dependencies();
}
