import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodfrenz/app/core/utils/pick_image.dart';
import 'package:foodfrenz/app/data/models/address_model.dart';
import 'package:foodfrenz/app/data/models/user_info_model.dart';
import 'package:foodfrenz/app/modules/authentication/authentication_controller.dart';
import 'package:foodfrenz/app/modules/profile/profile_repository.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ProfileController extends GetxController {
  final ProfileRepository profileRepository;

  ProfileController({required this.profileRepository});

  final String userId = Get.find<AuthenticationController>().user!.uid;
  final userChanges = Rx<User?>(null);
  final Rx<UserInfoModel> userInfo = UserInfoModel(
    createdAt: DateTime.now(),
    address: AddressModel(),
    transactions: 0,
    spending: 0,
  ).obs;
  final Rx<LatLng?> deliveryAddress = Rx<LatLng?>(null);

  @override
  void onReady() {
    userChanges.bindStream(profileRepository.userChanges);
    userInfo.bindStream(profileRepository.getUser(userId));
    setDeliveryAddress(userInfo.value.address.currentLocation);
    super.onReady();
  }

  Future<void> updateUserAuthProfile(
          {String? displayName, String? email, String? photoUrl}) =>
      profileRepository.updateUserAuthProfile(displayName, email, photoUrl);

  Future<void> updateUserInfoProfile(UserInfoModel userInfo) =>
      profileRepository.updateUserInfoProfile(userId, userInfo);

  Future<void> uploadProfileImage() async {
    final File? image = await pickImageFromGallery();
    final String imageUrl =
        await profileRepository.uploadProfileImage(userId, image);
    await updateUserAuthProfile(photoUrl: imageUrl);
  }

  void setDeliveryAddress(LatLng? latLng) {
    deliveryAddress.value = latLng;
  }
}
