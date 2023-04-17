import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodfrenz/app/data/models/user_info_model.dart';
import 'package:foodfrenz/app/data/providers/cloud_firestore_provider.dart';

class ProfileRepository {
  final CloudFirestoreProvider cloudFirestoreProvider;

  ProfileRepository({required this.cloudFirestoreProvider});

  Stream<UserInfoModel> getUser(String userId) =>
      cloudFirestoreProvider.getUser(userId);

  Stream<User?> get userChanges => cloudFirestoreProvider.userChanges;

  Future<void> updateUserProfile(String? displayName, String? email) =>
      cloudFirestoreProvider.updateUserProfile(displayName, email);
}
