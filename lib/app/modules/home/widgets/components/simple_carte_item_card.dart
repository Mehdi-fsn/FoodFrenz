import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodfrenz/app/core/theme/colors.dart';
import 'package:foodfrenz/app/core/utils/dimensions.dart';
import 'package:foodfrenz/app/data/models/carte_item_model.dart';
import 'package:foodfrenz/app/modules/home/pages/carte_item_details_page.dart';
import 'package:get/get.dart';

class SimpleCarteItemCard extends StatelessWidget {
  const SimpleCarteItemCard({Key? key, required this.item}) : super(key: key);

  final CarteItemModel item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          right: Dimensions.height20,
          left: Dimensions.height20,
          bottom: Dimensions.height10),
      height: Dimensions.height130,
      width: double.infinity,
      child: GestureDetector(
        onTap: () {
          // Get.toNamed(RoutePath.carteItemDetailsPagePath, arguments: item);
          Get.dialog(
            CarteItemDetailsPage(
              item: item,
            ),
            useSafeArea: false,
            barrierDismissible: false,
          );
        },
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
                padding: EdgeInsets.symmetric(vertical: Dimensions.width15),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(Dimensions.radius20),
                      bottomRight: Radius.circular(Dimensions.radius20),
                    ),
                    color: Get.theme.colorScheme.background,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(Dimensions.width10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          style: TextStyle(
                              color: Get.theme.colorScheme.onBackground,
                              fontSize: Dimensions.textSizeDefault),
                        ),
                        Text(item.description,
                            style: TextStyle(
                              color: AppColors.textColor,
                              fontSize: Dimensions.textSizeSmall,
                              overflow: TextOverflow.ellipsis,
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: List.generate(
                                5,
                                (index) => Icon(
                                  index < item.notes.round()
                                      ? Icons.star
                                      : Icons.star_border,
                                  color: AppColors.mainColor,
                                  size: Dimensions.iconSizeSmall,
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
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
