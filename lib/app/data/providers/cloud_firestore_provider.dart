import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodfrenz/app/data/models/carte_item_model.dart';

class CloudFirestoreProvider {
  Stream<List<CarteItemModel>> getAppetizers() {
    return FirebaseFirestore.instance
        .collection('appetizers')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map(
        (doc) {
          return CarteItemModel.fromJson(doc.data());
        },
      ).toList();
    });
  }

  Stream<List<CarteItemModel>> getMainCourses() {
    return FirebaseFirestore.instance
        .collection('main_courses')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map(
        (doc) {
          return CarteItemModel.fromJson(doc.data());
        },
      ).toList();
    });
  }

  Stream<List<CarteItemModel>> getDesserts() {
    return FirebaseFirestore.instance
        .collection('desserts')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map(
        (doc) {
          return CarteItemModel.fromJson(doc.data());
        },
      ).toList();
    });
  }

/*Future<Map<String, dynamic>> get fetchAllCarteItems async {
    final firestore = FirebaseFirestore.instance;
    Map<String, dynamic> res = {};

    QuerySnapshot querySnapshot =
        await firestore.collection('appetizers').get();
    res['appetizers'] = [];
    for (var doc in querySnapshot.docs) {
      var docData = doc.data() as Map<String, dynamic>;
      docData['category'] = CarteItemCategory.appetizer;
      res['appetizers'].add(docData);
    }

    querySnapshot = await firestore.collection('main_courses').get();
    res['main_courses'] = [];
    for (var doc in querySnapshot.docs) {
      var docData = doc.data() as Map<String, dynamic>;
      docData['category'] = CarteItemCategory.mainCourse;
      res['main_courses'].add(docData);
    }

    querySnapshot = await firestore.collection('desserts').get();
    res['desserts'] = [];
    for (var doc in querySnapshot.docs) {
      var docData = doc.data() as Map<String, dynamic>;
      docData['category'] = CarteItemCategory.dessert;
      res['desserts'].add(docData);
    }

    return res;
  }*/
}
