import 'package:foodfrenz/app/data/services/bindings/main_binding.dart';
import 'package:foodfrenz/app/modules/authentication/authentication_screen.dart';
import 'package:foodfrenz/app/modules/main_screen.dart';
import 'package:foodfrenz/app/routes/middlewares/authentication_middleware.dart';
import 'package:foodfrenz/app/routes/route_path.dart';
import 'package:get/get.dart';

final getPages = [
  // Main
  GetPage(
    name: RoutePath.basePath,
    page: () => const MainScreen(),
    binding: MainBinding(),
    middlewares: [
      AuthenticationMiddleware(),
    ],
  ),
  // Authentication Screen
  GetPage(
    name: RoutePath.authenticationScreenPath,
    page: () => const AuthenticationScreen(),
  ),
];
