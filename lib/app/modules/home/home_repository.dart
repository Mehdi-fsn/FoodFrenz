import 'dart:async';

import 'package:foodfrenz/app/data/models/carte_item_model.dart';
import 'package:foodfrenz/app/data/providers/cloud_firestore_provider.dart';

class HomeRepository {
  final CloudFirestoreProvider cloudFirestoreProvider;

  HomeRepository({required this.cloudFirestoreProvider});

  Stream<List<CarteItemModel>> getAppetizers() =>
      cloudFirestoreProvider.getAppetizers();

  Stream<List<CarteItemModel>> getMainCourses() =>
      cloudFirestoreProvider.getMainCourses();

  Stream<List<CarteItemModel>> getDesserts() =>
      cloudFirestoreProvider.getDesserts();
}
