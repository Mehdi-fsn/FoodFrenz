import 'dart:async';
import 'dart:math';

import 'package:foodfrenz/app/data/models/carte_item_model.dart';
import 'package:foodfrenz/app/modules/home/home_repository.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final HomeRepository _homeRepository;

  HomeController({required HomeRepository homeRepository})
      : _homeRepository = homeRepository;

  final appetizersItems = <CarteItemModel>[].obs;
  final mainCoursesItems = <CarteItemModel>[].obs;
  final dessertsItems = <CarteItemModel>[].obs;

  List<CarteItemModel> get allItems =>
      [...appetizersItems, ...mainCoursesItems, ...dessertsItems];

  StreamSubscription<List<CarteItemModel>>? _appetizersSubscription;
  StreamSubscription<List<CarteItemModel>>? _mainCoursesSubscription;
  StreamSubscription<List<CarteItemModel>>? _dessertsSubscription;

  @override
  void onInit() {
    super.onInit();
    _appetizersSubscription = _homeRepository.getAppetizers().listen((items) {
      appetizersItems.value = items;
    });
    _mainCoursesSubscription = _homeRepository.getMainCourses().listen((items) {
      mainCoursesItems.value = items;
    });
    _dessertsSubscription = _homeRepository.getDesserts().listen((items) {
      dessertsItems.value = items;
    });
  }

  @override
  void onClose() {
    _appetizersSubscription?.cancel();
    _mainCoursesSubscription?.cancel();
    _dessertsSubscription?.cancel();
    super.onClose();
  }

  List<CarteItemModel> get popularItems {
    List<CarteItemModel> topFiveItems = allItems;
    topFiveItems.sort((a, b) => b.notes.compareTo(a.notes));
    return topFiveItems.take(5).toList();
  }

  Future<List<CarteItemModel>> get recommendedItems async {
    final random = Random();
    final List<CarteItemModel> result = [];
    List indexes = [];

    while (allItems.isEmpty) {
      await Future.delayed(const Duration(milliseconds: 50));
    }

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
    return result;
  }
}
