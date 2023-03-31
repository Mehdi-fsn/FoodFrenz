import 'package:foodfrenz/app/core/utils/extensions.dart';
import 'package:get/get.dart';

class Dimensions {
  static double screenHeight = Get.height;
  static double screenWidth = Get.width;

  // Height based on Pixel 6 Pro (867 pixels)
  static double height5 = screenHeight / 173.4;
  static double height10 = screenHeight / 86.7;
  static double height15 = screenHeight / 57.8;
  static double height20 = screenHeight / 43.35;
  static double height30 = screenHeight / 28.9;
  static double height45 = screenHeight / 19.26;
  static double height50 = screenHeight / 17.34;
  static double height130 = screenHeight / 6.66;

  // Width based on Pixel 6 Pro (411 pixels)
  static double width3 = screenWidth / 137;
  static double width5 = screenWidth / 82.2;
  static double width10 = screenWidth / 41.1;
  static double width15 = screenWidth / 27.4;
  static double width20 = screenWidth / 20.55;
  static double width45 = screenWidth / 9.13;

  // Text Size
  static double textSizeExtraSmall = 8.0.sp;
  static double textSize9 = 9.0.sp;
  static double textSizeSmall = 10.0.sp;
  static double textSize11 = 11.0.sp;
  static double textSizeDefault = 12.0.sp;
  static double textSizeMedium = 14.0.sp;
  static double textSizeLarge = 16.0.sp;
  static double textSizeExtraLarge = 18.0.sp;
  static double textSize30 = 30.0.sp;

  // Icon Size
  static double iconSizeExtraSmall = 14.0.sp;
  static double iconSizeSmall = 16.0.sp;

  // Radius
  static double radius5 = screenHeight / 173.4;
  static double radius20 = screenHeight / 43.35;
  static double radius30 = screenHeight / 28.9;

  // Home Screen
  static double homeRecommendedItemsView = screenHeight / 2.89;
  static double homeRecommendedItemsViewWhiteCard = screenHeight / 6.80;
}
