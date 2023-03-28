import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:foodfrenz/app/core/theme/colors.dart';
import 'package:foodfrenz/app/core/utils/dimensions.dart';
import 'package:foodfrenz/app/core/utils/functions/format.dart';
import 'package:foodfrenz/app/data/models/carte_item_model.dart';
import 'package:foodfrenz/app/widgets/icon_and_text_widget.dart';
import 'package:get/get.dart';

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
  final _height4Transform = Dimensions.homeRecommendedItemsView / 1.2;

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
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: Dimensions.homeRecommendedItemsView,
          child: PageView.builder(
              controller: _pageController,
              itemCount: 5,
              itemBuilder: (context, index) {
                return _buildItemCard(widget.recommendedItems![index], index);
              }),
        ),
        SizedBox(height: Dimensions.height20),
        DotsIndicator(
          dotsCount: 5,
          position: _currentPageValue,
          decorator: DotsDecorator(
            size: const Size.square(9.0),
            activeSize: const Size(18.0, 9.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            activeColor: Get.theme.brightness == Brightness.dark
                ? AppColors.mainDarkColor
                : AppColors.mainColor,
          ),
        ),
      ],
    );
  }

  Widget _buildItemCard(CarteItemModel item, int index) {
    // Transform the item based on the current page value
    Matrix4 matrix = Matrix4.identity();
    if (index == _currentPageValue.floor()) {
      var currentScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currentTrans = _height4Transform * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1);
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTrans, 0);
    } else if (index == _currentPageValue.floor() + 1) {
      var currentScale =
          _scaleFactor + (_currentPageValue - index + 1) * (1 - _scaleFactor);
      var currentTrans = _height4Transform * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1);
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTrans, 0);
    } else if (index == _currentPageValue.floor() - 1) {
      var currentScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currentTrans = _height4Transform * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1);
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTrans, 0);
    } else {
      var currentScale = _scaleFactor;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, _height4Transform * (1 - _scaleFactor) / 2, 1);
    }

    return Transform(
      transform: matrix,
      child: Container(
        margin: const EdgeInsets.only(right: 10, left: 10),
        child: Stack(children: [
          SizedBox(
            height: _height4Transform,
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
              height: Dimensions.homeRecommendedItemsViewWhiteCard,
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
                padding: EdgeInsets.only(
                    left: Dimensions.height15,
                    right: Dimensions.height15,
                    top: Dimensions.height15,
                    bottom: Dimensions.height10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: TextStyle(
                          color: Colors.black87,
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
                                  size: Dimensions.textSizeLarge,
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
                          '${Format.formatNumber(item.comments)} comments',
                          style: TextStyle(
                              color: AppColors.textColor,
                              fontSize: Dimensions.textSize11),
                        ),
                      ],
                    ),
                    SizedBox(height: Dimensions.height15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconAndTextWidget(
                          icon: Icons.public,
                          text: item.origin,
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
}
