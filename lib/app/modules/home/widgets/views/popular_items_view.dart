import 'package:flutter/material.dart';
import 'package:foodfrenz/app/core/constant/constants.dart';
import 'package:foodfrenz/app/core/utils/dimensions.dart';
import 'package:foodfrenz/app/data/models/carte_item_model.dart';
import 'package:foodfrenz/app/modules/home/widgets/components/simple_carte_item_card.dart';

class PopularItemsView extends StatelessWidget {
  const PopularItemsView({Key? key, required this.popularItems})
      : super(key: key);

  final List<CarteItemModel> popularItems;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(top: Dimensions.height30),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: Constants.popularItemsNumber,
      itemBuilder: (context, index) {
        return SimpleCarteItemCard(item: popularItems[index]);
      },
    );
  }
}
