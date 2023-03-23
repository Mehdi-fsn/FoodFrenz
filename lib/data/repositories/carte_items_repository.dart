import 'dart:math';

import 'package:foodfrenz/data/api/cloud_firestore_api.dart';
import 'package:foodfrenz/models/carte_item_model.dart';
import 'package:foodfrenz/utils/constant/enum.dart';

class CarteItemsRepository {
  final CloudFirestoreAPI cloudFirestoreAPI = CloudFirestoreAPI();
  List<CarteItemModel> allItems = [];
  List<CarteItemModel> appetizersItems = [];
  List<CarteItemModel> mainCoursesItems = [];
  List<CarteItemModel> dessertsItems = [];
  List<CarteItemModel> recommendedItems = [];
  List<CarteItemModel> popularItems = [];

  CarteItemsRepository();

  Future<Map<String, List<CarteItemModel>>> get allCarteItems async {
    Map<String, dynamic> itemsByCategory =
    await cloudFirestoreAPI.fetchAllCarteItems();

    if (allItems.isNotEmpty) {
      return {
        'appetizers': appetizersItems,
        'main_courses': mainCoursesItems,
        'desserts': dessertsItems,
        'recommended': recommendedItems,
        'popular': popularItems,
      };
    } else {
      for (var category in itemsByCategory.entries) {
        switch (category.key) {
          case 'appetizers':
            for (var item in category.value) {
              appetizersItems.add(CarteItemModel.fromMap(item));
            }
            break;
          case 'main_courses':
            for (var item in category.value) {
              mainCoursesItems.add(CarteItemModel.fromMap(item));
            }
            break;
          case 'desserts':
            for (var item in category.value) {
              dessertsItems.add(CarteItemModel.fromMap(item));
            }
            break;
        }
      }
      allItems = appetizersItems + mainCoursesItems + dessertsItems;

      getRecommendedCarteItems();
      getPopularCarteItems();

      return {
        'appetizers': appetizersItems,
        'main_courses': mainCoursesItems,
        'desserts': dessertsItems,
        'recommended': recommendedItems,
        'popular': popularItems,
      };
    }
  }

  List<CarteItemModel> getItemsByCategory(CarteItemCategory category) {
    switch (category) {
      case CarteItemCategory.appetizer:
        return appetizersItems;
      case CarteItemCategory.mainCourse:
        return mainCoursesItems;
      case CarteItemCategory.dessert:
        return dessertsItems;
      default:
        return [];
    }
  }

  List<CarteItemModel> getPopularCarteItems() {
    List<CarteItemModel> topFiveItems = allItems;
    topFiveItems.sort((a, b) => b.notes.compareTo(a.notes));
    popularItems = topFiveItems.take(5).toList();
    return popularItems;
  }

  List<CarteItemModel> getRecommendedCarteItems() {
    final random = Random();
    final List<CarteItemModel> result = [];
    List indexes = [];
    while (result.length < 5) {
      final index = random.nextInt(allItems.length);
      if (!indexes.contains(index)) {
        indexes.add(index);
      } else {
        continue;
      }
      final item = allItems[index];
      result.add(item);
    }
    recommendedItems = result;
    return recommendedItems;
  }
}
