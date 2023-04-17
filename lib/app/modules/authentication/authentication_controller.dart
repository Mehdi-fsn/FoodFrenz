import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:foodfrenz/app/modules/authentication/authentication_repository.dart';
import 'package:foodfrenz/app/routes/route_path.dart';
import 'package:get/get.dart';

class AuthenticationController extends GetxController {
  final AuthenticationRepository authenticationRepository;

  AuthenticationController(this.authenticationRepository);

  final _user = Rx<User?>(null);

  User? get user => _user.value;

  @override
  void onReady() {
    _user.bindStream(authenticationRepository.auth);

    ever(_user, (_) {
      if (user == null) Get.offAllNamed(RoutePath.authenticationScreenPath);
    });
    super.onReady();
  }

  Future<String?> signIn(LoginData data) async {
    final result = await authenticationRepository.signIn(
        email: data.name, password: data.password);
    return result;
  }

  Future<String?> signInWithGoogle() async {
    final result = await authenticationRepository.signInWithGoogle();
    return result;
  }

  Future<String?> signUp(SignupData data) async {
    final result = await authenticationRepository.signUp(
        email: data.name!, password: data.password!);
    return result;
  }

  Future<void> signOut() async {
    await authenticationRepository.signOut();
  }

  Future<String?> recoverPassword(String email) async {
    final result = await authenticationRepository.recoverPassword(email: email);
    return result;
  }
}
