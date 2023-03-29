import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodfrenz/app/core/constant/constants.dart';
import 'package:foodfrenz/app/core/utils/dimensions.dart';
import 'package:foodfrenz/app/data/models/carte_item_model.dart';

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
        return _buildItemCard(popularItems[index]);
      },
    );
  }

  Widget _buildItemCard(CarteItemModel item) {
    return Container(
      margin: EdgeInsets.only(
          right: Dimensions.height20,
          left: Dimensions.height20,
          bottom: Dimensions.height10),
      height: Dimensions.height130,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: CachedNetworkImage(
              imageUrl: item.image,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              placeholder: (context, url) => const Center(
                child: SizedBox.shrink(),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: Dimensions.width5),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Colors.green,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
