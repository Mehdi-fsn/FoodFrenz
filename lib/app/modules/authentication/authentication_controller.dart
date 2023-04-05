import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:foodfrenz/app/modules/authentication/authentication_repository.dart';
import 'package:get/get.dart';

class AuthenticationController extends GetxController {
  final AuthenticationRepository repository;

  AuthenticationController(this.repository);

  final _user = Rx<User?>(null);

  User? get user => _user.value;

  @override
  void onReady() {
    _user.bindStream(repository.auth);
    super.onReady();
  }

  Future<String?> signIn(LoginData data) async {
    final result =
        await repository.signIn(email: data.name, password: data.password);
    return result;
  }

  Future<String?> signInWithGoogle() async {
    final result = await repository.signInWithGoogle();
    return result;
  }

  Future<String?> signUp(SignupData data) async {
    final result =
        await repository.signUp(email: data.name!, password: data.password!);
    return result;
  }

  Future<void> signOut() async {
    await repository.signOut();
  }

  Future<String?> recoverPassword(String email) async {
    final result = await repository.recoverPassword(email: email);
    return result;
  }
}
