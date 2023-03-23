import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:foodfrenz/data/bloc/theme/theme_bloc.dart';
import 'package:foodfrenz/data/repositories/carte_items_repository.dart';
import 'package:foodfrenz/modules/login/login_screen.dart';
import 'package:foodfrenz/utils/constant/app_path.dart';
import 'package:foodfrenz/utils/constant/color_schemes.g.dart';

import 'modules/home/home_screen.dart';

class AppModule extends Module {

  @override
  List<Bind<Object>> get binds => [
    Bind.singleton((i) => CarteItemsRepository()),
  ];

  @override
  List<ModularRoute> get routes =>
      [
        ChildRoute(
          AppPath.homeScreenPath,
          child: (context, args) => const HomeScreen(),
        ),
        ChildRoute(
          AppPath.loginScreenPath,
          child: (context, args) => const LoginScreen(),
        ),
      ];
}

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeBloc(),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
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
            themeMode: state.themeMode,
            routerDelegate: Modular.routerDelegate,
            routeInformationParser: Modular.routeInformationParser,
          );
        },
      ),
    );
  }
}
