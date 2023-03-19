import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:foodfrenz/firebase_options.dart';
import 'package:foodfrenz/main_module.dart';
import 'package:foodfrenz/utils/constant/app_path.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Modular.setInitialRoute(AppPath.homeScreenPath);

  runApp(ModularApp(
    module: AppModule(),
    child: const AppWidget(),
  ));
}
