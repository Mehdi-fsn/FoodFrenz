import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foodfrenz/app/core/theme/color_schemes.g.dart';
import 'package:foodfrenz/app/core/utils/firebase_options.dart';
import 'package:foodfrenz/app/data/providers/cloud_firestore_provider.dart';
import 'package:foodfrenz/app/routes/pages.dart';
import 'package:foodfrenz/app/routes/route_path.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FoodFrenz',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
        fontFamily: 'Roboto',
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: darkColorScheme,
        fontFamily: 'Roboto',
      ),
      themeMode: ThemeMode.light,
      unknownRoute: GetPage(
        name: RoutePath.notFoundScreenPath,
        page: () => const Center(
          child: Text('404 Not Found'),
        ),
      ),
      initialRoute: RoutePath.homeScreenPath,
      getPages: getPages,
      initialBinding: BindingsBuilder(
        () {
          Get.lazyPut(() => CloudFirestoreProvider());
        },
      ),
    );
  }
}
