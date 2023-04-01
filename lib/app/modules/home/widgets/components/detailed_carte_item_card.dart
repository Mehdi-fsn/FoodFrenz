import 'package:flutter/material.dart';
import 'package:foodfrenz/app/core/constant/constants.dart';
import 'package:foodfrenz/app/core/theme/colors.dart';
import 'package:foodfrenz/app/core/utils/dimensions.dart';
import 'package:foodfrenz/app/core/utils/format.dart';
import 'package:foodfrenz/app/data/models/carte_item_model.dart';
import 'package:foodfrenz/app/widgets/icon_and_text_widget.dart';
import 'package:get/get.dart';

class DetailedCarteItemCard extends StatelessWidget {
  const DetailedCarteItemCard(
      {Key? key, required this.item, this.seePrice = false})
      : super(key: key);

  final CarteItemModel item;
  final bool seePrice;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item.name,
          style: TextStyle(
              color: Get.theme.colorScheme.onBackground,
              fontSize: Dimensions.textSizeLarge),
        ),
        SizedBox(height: Dimensions.height10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Wrap(
                  children: List.generate(
                    5,
                    (index) => Icon(
                      index < item.notes.round()
                          ? Icons.star
                          : Icons.star_border,
                      color: AppColors.mainColor,
                      size: Dimensions.iconSizeMedium,
                    ),
                  ),
                ),
                SizedBox(width: Dimensions.width5),
                Text(
                  item.notes.toString(),
                  style: TextStyle(
                      color: AppColors.textColor,
                      fontSize: Dimensions.textSize11),
                ),
              ],
            ),
            Text(
              '${Format.formatNumber(item.comments)} ${Constants.comments}',
              style: TextStyle(
                  color: AppColors.textColor, fontSize: Dimensions.textSize11),
            ),
          ],
        ),
        SizedBox(height: Dimensions.height15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ...seePrice
                ? [
                    IconAndTextWidget(
                        icon: Icons.monetization_on_outlined,
                        text: '${Constants.dollar}${item.price}',
                        textColor: AppColors.textColor,
                        iconColor: AppColors.mainDarkColor)
                  ]
                : [],
            IconAndTextWidget(
              icon: Icons.public,
              text: item.origin,
              textColor: AppColors.textColor,
              iconColor: AppColors.iconColor1,
            ),
            IconAndTextWidget(
              icon: Icons.location_on,
              text: '${item.distance.toString()}${Constants.km}',
              textColor: AppColors.textColor,
              iconColor: AppColors.mainColor,
            ),
            IconAndTextWidget(
              icon: Icons.access_time_rounded,
              text: '${(19 * item.distance + 10).round()}${Constants.min}',
              textColor: AppColors.textColor,
              iconColor: AppColors.iconColor2,
            ),
          ],
        )
      ],
    );
  }
}
