import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodfrenz/app/data/models/user_info_model.dart';
import 'package:foodfrenz/app/modules/authentication/authentication_controller.dart';
import 'package:foodfrenz/app/modules/profile/profile_repository.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final ProfileRepository profileRepository;

  ProfileController({required this.profileRepository});

  final String userId = Get.find<AuthenticationController>().user!.uid;
  final userChanges = Rx<User?>(null);
  final Rx<UserInfoModel> userInfo = UserInfoModel(
          createdAt: DateTime.now(), address: {}, transactions: 0, spending: 0)
      .obs;

  @override
  void onInit() {
    super.onInit();
    userChanges.bindStream(profileRepository.userChanges);
    userInfo.bindStream(profileRepository.getUser(userId));
  }

  Future<void> updateUserProfile({String? displayName, String? email}) =>
      profileRepository.updateUserProfile(displayName, email);
}
