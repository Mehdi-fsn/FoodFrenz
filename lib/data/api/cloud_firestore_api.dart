import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodfrenz/utils/constant/enum.dart';

class CloudFirestoreAPI {

  Future<Map<String, dynamic>> fetchAllCarteItems() async {
    Map<String, dynamic> res = {};

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('appetizers').get();
    res['appetizers'] = [];
    for (var doc in querySnapshot.docs) {
      var docData = doc.data() as Map<String, dynamic>;
      docData['category'] = CarteItemCategory.appetizer;
      res['appetizers'].add(docData);
    }

    querySnapshot = await FirebaseFirestore.instance.collection('main_courses').get();
    res['main_courses'] = [];
    for (var doc in querySnapshot.docs) {
      var docData = doc.data() as Map<String, dynamic>;
      docData['category'] = CarteItemCategory.mainCourse;
      res['main_courses'].add(docData);
    }

    querySnapshot = await FirebaseFirestore.instance.collection('desserts').get();
    res['desserts'] = [];
    for (var doc in querySnapshot.docs) {
      var docData = doc.data() as Map<String, dynamic>;
      docData['category'] = CarteItemCategory.dessert;
      res['desserts'].add(docData);
    }

    return res;
  }
}