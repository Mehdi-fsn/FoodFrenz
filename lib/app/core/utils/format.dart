import 'package:foodfrenz/app/core/constant/constants.dart';
import 'package:foodfrenz/app/data/enums.dart';

class Format {
  static String formatCategoryCarteItemToString(CarteItemCategory category) {
    switch (category) {
      case CarteItemCategory.appetizer:
        return Constants.appetizers;
      case CarteItemCategory.mainCourse:
        return Constants.mainCourses;
      case CarteItemCategory.dessert:
        return Constants.desserts;
    }
  }

  static String formatStatusOrderToString(StatusOrder status) {
    switch (status) {
      case StatusOrder.cancelled:
        return 'Cancelled';
      case StatusOrder.pending:
        return 'Pending';
      case StatusOrder.delivered:
        return 'Delivered';
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
