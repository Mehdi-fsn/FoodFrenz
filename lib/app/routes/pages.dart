import 'package:foodfrenz/app/modules/authentication/authentication_screen.dart';
import 'package:foodfrenz/app/modules/home/pages/all_carte_item_page.dart';
import 'package:foodfrenz/app/modules/home/pages/carte_item_details_page.dart';
import 'package:foodfrenz/app/modules/main_screen.dart';
import 'package:foodfrenz/app/routes/route_path.dart';
import 'package:get/get.dart';

final getPages = [
  // Base Page
  GetPage(
    name: RoutePath.basePath,
    page: () => const MainScreen(),
  ),

  // Home Another Pages
  GetPage(
    name: RoutePath.allItemsPagePath,
    page: () => AllCarteItemsPage(),
    transition: Transition.rightToLeftWithFade,
  ),
  GetPage(
    name: RoutePath.carteItemDetailsPagePath,
    page: () => CarteItemDetailsPage(),
    transition: Transition.rightToLeftWithFade,
  ),

  // Authentication Screen
  GetPage(
    name: RoutePath.authenticationScreen,
    page: () => const AuthenticationScreen(),
  ),
];
