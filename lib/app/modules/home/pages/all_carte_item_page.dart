import 'package:flutter/material.dart';

// import 'package:foodfrenz/app/core/utils/format.dart';
// import 'package:foodfrenz/app/data/enums.dart';

class AllCarteItemsPage extends StatelessWidget {
  const AllCarteItemsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: const [
            Center(child: Text("All Carte Items Page")),
            /* Chip(label: Text(Format.formatCategoryCarteItemToString(CarteItemCategory.appetizer))),
            Chip(label: Text(Format.formatCategoryCarteItemToString(CarteItemCategory.mainCourse))),
            Chip(label: Text(Format.formatCategoryCarteItemToString(CarteItemCategory.dessert))),*/
          ],
        ),
      ],
    );
  }
}
