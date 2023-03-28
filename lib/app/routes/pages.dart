import 'package:foodfrenz/app/modules/authentication/login/login_screen.dart';
import 'package:foodfrenz/app/modules/authentication/signup/signup_screen.dart';
import 'package:foodfrenz/app/modules/home/home_binding.dart';
import 'package:foodfrenz/app/modules/home/home_screen.dart';
import 'package:foodfrenz/app/modules/profile/profile_screen.dart';
import 'package:foodfrenz/app/modules/shopping_cart/shopping_cart_screen.dart';
import 'package:foodfrenz/app/routes/route_path.dart';
import 'package:get/get.dart';

final getPages = [
  GetPage(
    name: RoutePath.homeScreenPath,
    page: () => const HomeScreen(),
    binding: HomeBinding(),
  ),
  GetPage(
      name: RoutePath.shoppingCartScreenPath,
      page: () => const ShoppingCartScreen()),
  GetPage(name: RoutePath.profileScreenPath, page: () => const ProfileScreen()),
  GetPage(name: RoutePath.loginScreenPath, page: () => const LoginScreen()),
  GetPage(name: RoutePath.signupScreenPath, page: () => const SignupScreen()),
];
