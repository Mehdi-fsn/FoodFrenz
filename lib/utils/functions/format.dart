import 'package:foodfrenz/utils/constant/enum.dart';

class Format {
  static String formatCategoryCarteItem(CarteItemCategory category) {
    switch (category) {
      case CarteItemCategory.mainCourse:
        return 'Main Course';
      default:
        return category.name[0].toUpperCase() + category.name.substring(1);
    }
  }
}