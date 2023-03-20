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
  var _currentPageValue = 0.0;
  final _scaleFactor = 0.8;
  final _height4Transform = 250.0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPageValue = _pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

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

    // Transform the item based on the current page value
    Matrix4 matrix = Matrix4.identity();
    if(index == _currentPageValue.floor()) {
        var currentScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
        var currentTrans = _height4Transform * (1 - currentScale) / 2;
        matrix = Matrix4.diagonal3Values(1, currentScale, 1);
        matrix = Matrix4.diagonal3Values(1, currentScale, 1)..setTranslationRaw(0, currentTrans, 0);
    } else if(index == _currentPageValue.floor() + 1) {
        var currentScale = _scaleFactor + (_currentPageValue - index + 1) * (1 - _scaleFactor);
        var currentTrans = _height4Transform * (1 - currentScale) / 2;
        matrix = Matrix4.diagonal3Values(1, currentScale, 1);
        matrix = Matrix4.diagonal3Values(1, currentScale, 1)..setTranslationRaw(0, currentTrans, 0);
    } else if(index == _currentPageValue.floor() - 1) {
      var currentScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currentTrans = _height4Transform * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1);
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)..setTranslationRaw(0, currentTrans, 0);
    } else {
      var currentScale = _scaleFactor;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)..setTranslationRaw(0, _height4Transform * (1 - _scaleFactor)/2, 1 );
    }

    return Transform(
      transform: matrix,
      child: Container(
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
                    blurRadius: 5,
                    offset: Offset(0, 5),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(-5, 0),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(5, 0),
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
      ),
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
