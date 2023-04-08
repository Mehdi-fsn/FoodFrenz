import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodfrenz/app/core/theme/colors.dart';
import 'package:foodfrenz/app/core/utils/dimensions.dart';
import 'package:foodfrenz/app/modules/authentication/authentication_controller.dart';
import 'package:foodfrenz/app/routes/route_path.dart';
import 'package:get/get.dart';

class AuthenticationScreen extends GetView<AuthenticationController> {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FlutterLogin(
      logo: 'assets/images/logo_foodfrenz.png',
      onLogin: controller.signIn,
      onSignup: controller.signUp,
      onSubmitAnimationCompleted: () {
        Get.toNamed(RoutePath.basePath);
      },
      onRecoverPassword: controller.recoverPassword,
      loginProviders: [
        LoginProvider(
          icon: FontAwesomeIcons.google,
          label: 'Google',
          callback: controller.signInWithGoogle,
        ),
      ],
      theme: LoginTheme(
        pageColorDark: AppColors.mainColor,
        accentColor: AppColors.mainColor,
        cardTheme: CardTheme(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius20),
          ),
        ),
        inputTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.zero,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.paraColor),
            borderRadius: BorderRadius.circular(Dimensions.radius10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.paraColor),
            borderRadius: BorderRadius.circular(Dimensions.radius10),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(Dimensions.radius10),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(Dimensions.radius10),
          ),
        ),
        buttonTheme: LoginButtonTheme(
          splashColor: Colors.white,
          backgroundColor: AppColors.mainColor,
          highlightColor: Colors.white,
          elevation: 5,
          highlightElevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius10),
          ),
        ),
      ),
    ));
  }
}
