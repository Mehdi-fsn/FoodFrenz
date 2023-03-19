import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodfrenz/models/carte_item_model.dart';
import 'package:foodfrenz/utils/constant/colors.dart';
import 'package:foodfrenz/utils/constant/enum.dart';
import 'package:foodfrenz/utils/widgets/icon_and_text_widget.dart';

class RecommendedItemsView extends StatefulWidget {
  const RecommendedItemsView({Key? key, required this.recommendedItems})
      : super(key: key);

  final List<CarteItemModel>? recommendedItems;

  @override
  State<RecommendedItemsView> createState() => _RecommendedItemsViewState();
}

class _RecommendedItemsViewState extends State<RecommendedItemsView> {
  final PageController _pageController = PageController(viewportFraction: 0.85);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 325,
      child: PageView.builder(
          controller: _pageController,
          itemCount: 5,
          itemBuilder: (context, index) {
            return _buildItem(widget.recommendedItems![index], index);
          }),
    );
  }

  Widget _buildItem(CarteItemModel? item, int index) {
    final String categoryToString = _formatCategory(item!.category);
    return Container(
      margin: const EdgeInsets.only(right: 10, left: 10),
      child: Stack(children: [
        SizedBox(
          height: 250,
          child: CachedNetworkImage(
            imageUrl: item.image,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
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
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            height: 130,
            margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 15, bottom: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 7),
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
                            size: 18,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        item.notes.toString(),
                        style: const TextStyle(color: AppColors.textColor),
                      ),
                      const SizedBox(width: 15),
                      Text(
                        '${item.comments} comments',
                        style: const TextStyle(color: AppColors.textColor),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconAndTextWidget(
                        icon: Icons.circle_sharp,
                        text: categoryToString,
                        textColor: AppColors.textColor,
                        iconColor: AppColors.iconColor1,
                      ),
                      IconAndTextWidget(
                        icon: Icons.location_on,
                        text: '${item.distance.toString()}km',
                        textColor: AppColors.textColor,
                        iconColor: AppColors.mainColor,
                      ),
                      IconAndTextWidget(
                        icon: Icons.access_time_rounded,
                        text: '${(19 * item.distance + 10).round()}min',
                        textColor: AppColors.textColor,
                        iconColor: AppColors.iconColor2,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        )
      ]),
    );
  }

  String _formatCategory(CarteItemCategory category) {
    switch (category) {
      case CarteItemCategory.mainCourse:
        return 'Main Course';
      default:
        return category.name[0].toUpperCase() + category.name.substring(1);
    }
  }
}
