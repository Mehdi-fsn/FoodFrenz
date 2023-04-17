import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodfrenz/app/data/models/user_info_model.dart';
import 'package:foodfrenz/app/data/providers/cloud_firestore_provider.dart';

class ProfileRepository {
  final CloudFirestoreProvider cloudFirestoreProvider;

  ProfileRepository({required this.cloudFirestoreProvider});

  Stream<UserInfoModel> getUser(String userId) =>
      cloudFirestoreProvider.getUser(userId);

  Stream<User?> get userChanges => cloudFirestoreProvider.userChanges;

  Future<void> updateUserAuthProfile(
          String? displayName, String? email, String? photoUrl) =>
      cloudFirestoreProvider.updateUserAuthProfile(
          displayName, email, photoUrl);

  Future<void> updateUserInfoProfile(String userId, UserInfoModel userInfo) =>
      cloudFirestoreProvider.updateUserInfoProfile(userId, userInfo);

  Future<String> uploadProfileImage(String userId, File? image) =>
      cloudFirestoreProvider.uploadProfileImage(userId, image);
}
