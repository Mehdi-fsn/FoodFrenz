import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:foodfrenz/data/bloc/theme/theme_bloc.dart';
import 'package:foodfrenz/data/repositories/carte_items_repository.dart';
import 'package:foodfrenz/models/carte_item_model.dart';
import 'package:foodfrenz/modules/home/widget/recommended_items_view.dart';
import 'package:foodfrenz/utils/constant/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0, left: 20.0),
            child: Container(
              margin: const EdgeInsets.only(top: 45.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'FoodFrenz',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? AppColors.mainDarkColor
                            : AppColors.mainColor,
                        fontWeight: FontWeight.bold),
                  ),
                  BlocBuilder<ThemeBloc, ThemeState>(
                    builder: (context, state) {
                      return FloatingActionButton(
                          onPressed: () {
                            switch (state.themeMode) {
                              case ThemeMode.dark:
                                BlocProvider.of<ThemeBloc>(context).add(
                                    const SwitchThemeEvent(
                                        themeMode: ThemeMode.light));
                                break;
                              default:
                                BlocProvider.of<ThemeBloc>(context).add(
                                    const SwitchThemeEvent(
                                        themeMode: ThemeMode.dark));
                            }
                          },
                        backgroundColor: Theme.of(context).brightness == Brightness.dark
                            ? AppColors.mainDarkColor
                            : AppColors.mainColor,
                          child: Icon(state.themeMode == ThemeMode.dark
                              ? Icons.nightlight_outlined
                              : Icons.wb_sunny_outlined, color: Colors.black87),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          FutureBuilder(
            future: Modular.get<CarteItemsRepository>().allCarteItems,
            builder: (context,
                AsyncSnapshot<Map<String, List<CarteItemModel>>> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                default:
                  if (snapshot.hasError) {
                    return const Center(child: Text("Error"));
                  } else {
                    return Column(children: [
                      RecommendedItemsView(
                        recommendedItems: snapshot.data!['recommended'],
                      ),
                      const SizedBox(height: 20),
                    ]);
                  }
              }
            },
          )
        ],
      ),
    );
  }
}
