import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodfrenz/app/data/models/user_model.dart';
import 'package:foodfrenz/app/modules/authentication/authentication_controller.dart';
import 'package:foodfrenz/app/modules/profile/profile_repository.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final ProfileRepository profileRepository;

  ProfileController({required this.profileRepository});

  final User userAuth = Get.find<AuthenticationController>().user!;
  final Rx<UserModel> userInfo = UserModel(
          createdAt: DateTime.now(), address: {}, transactions: 0, spending: 0)
      .obs;

  @override
  void onInit() {
    super.onInit();
    userInfo.bindStream(profileRepository.getUser(userAuth.uid));
  }
}
