import 'dart:async';
import 'dart:math';

import 'package:foodfrenz/app/core/constant/constants.dart';
import 'package:foodfrenz/app/data/models/carte_item_model.dart';
import 'package:foodfrenz/app/modules/home/home_repository.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final HomeRepository homeRepository;

  HomeController({required this.homeRepository});

  final appetizerItems = <CarteItemModel>[].obs;
  final mainCourseItems = <CarteItemModel>[].obs;
  final dessertItems = <CarteItemModel>[].obs;

  List<CarteItemModel> get allItems =>
      [...appetizerItems, ...mainCourseItems, ...dessertItems];

  StreamSubscription<List<CarteItemModel>>? _appetizersSubscription;
  StreamSubscription<List<CarteItemModel>>? _mainCoursesSubscription;
  StreamSubscription<List<CarteItemModel>>? _dessertsSubscription;

  @override
  void onInit() {
    super.onInit();
    _appetizersSubscription = homeRepository.getAppetizers().listen((items) {
      appetizerItems.value = items;
    });
    _mainCoursesSubscription = homeRepository.getMainCourses().listen((items) {
      mainCourseItems.value = items;
    });
    _dessertsSubscription = homeRepository.getDesserts().listen((items) {
      dessertItems.value = items;
    });
  }

  @override
  void onClose() {
    _appetizersSubscription?.cancel();
    _mainCoursesSubscription?.cancel();
    _dessertsSubscription?.cancel();
    super.onClose();
  }

  Future<List<CarteItemModel>> get popularItems async {
    while (allItems.isEmpty) {
      await Future.delayed(const Duration(milliseconds: 50));
    }

    List<CarteItemModel> topFiveItems = allItems;
    topFiveItems.sort((a, b) => b.notes.compareTo(a.notes));
    return topFiveItems.take(Constants.popularItemsNumber).toList();
  }

  Future<List<CarteItemModel>> get recommendedItems async {
    while (allItems.isEmpty) {
      await Future.delayed(const Duration(milliseconds: 50));
    }

    final random = Random();
    final List<CarteItemModel> result = [];
    List indexes = [];
    while (result.length < Constants.recommendedItemsNumber) {
      final index = random.nextInt(allItems.length);
      if (!indexes.contains(index)) {
        indexes.add(index);
      } else {
        continue;
      }
      final item = allItems[index];
      result.add(item);
    }
    return result;
  }
}
