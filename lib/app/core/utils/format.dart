import 'package:foodfrenz/app/data/enums.dart';

class Format {
  static String formatCategoryCarteItemToString(CarteItemCategory category) {
    switch (category) {
      case CarteItemCategory.mainCourse:
        return 'Main Course';
      default:
        return category.name[0].toUpperCase() + category.name.substring(1);
    }
  }

  static String formatNumber(int number) {
    if (number < 1000) {
      return number.toString();
    } else if (number < 1000000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    } else if (number < 1000000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number < 1000000000000) {
      return '${(number / 1000000000).toStringAsFixed(1)}B';
    } else {
      return '${(number / 1000000000000).toStringAsFixed(1)}T';
    }
  }
}
