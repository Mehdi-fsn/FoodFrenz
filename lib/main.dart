import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foodfrenz/app/core/theme/color_schemes.g.dart';
import 'package:foodfrenz/app/core/utils/firebase_options.dart';
import 'package:foodfrenz/app/data/services/bindings/init_bindings.dart';
import 'package:foodfrenz/app/routes/pages.dart';
import 'package:foodfrenz/app/routes/route_path.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await initBindings();
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
      defaultTransition: Transition.fade,
      initialRoute: RoutePath.basePath,
      getPages: getPages,
    );
  }
}
