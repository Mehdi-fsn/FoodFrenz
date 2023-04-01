import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:foodfrenz/app/core/constant/constants.dart';
import 'package:foodfrenz/app/core/theme/colors.dart';
import 'package:foodfrenz/app/core/utils/dimensions.dart';
import 'package:foodfrenz/app/data/models/carte_item_model.dart';
import 'package:foodfrenz/app/modules/home/widgets/components/detailed_carte_item_card.dart';
import 'package:foodfrenz/app/routes/route_path.dart';
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

  // For transforming the items
  var _currentPageValue = 0.0;
  final _scaleFactor = 0.8;
  final _height4Transform = Dimensions.homeRecommendedItemsView / 1.25;

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
              itemCount: Constants.recommendedItemsNumber,
              itemBuilder: (context, index) {
                return _buildItemCard(widget.recommendedItems![index], index);
              }),
        ),
        SizedBox(height: Dimensions.height20),
        DotsIndicator(
          dotsCount: Constants.recommendedItemsNumber,
          position: _currentPageValue,
          decorator: DotsDecorator(
            size: const Size.square(9.0),
            activeSize: const Size(18.0, 9.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Dimensions.radius5)),
            activeColor:
                Get.isDarkMode ? AppColors.mainDarkColor : AppColors.mainColor,
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
      child: GestureDetector(
        onTap: () {
          Get.toNamed(
              '${RoutePath.homeScreenPath}${RoutePath.carteItemDetailsPagePath}',
              arguments: item);
        },
        child: Container(
          margin: EdgeInsets.only(
              right: Dimensions.width10, left: Dimensions.width10),
          child: Stack(children: [
            SizedBox(
              height: _height4Transform,
              child: CachedNetworkImage(
                imageUrl: item.image,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius30),
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
                height: Dimensions.homeRecommendedItemsViewCard,
                margin: EdgeInsets.only(
                    left: Dimensions.width10,
                    right: Dimensions.width10,
                    bottom: Dimensions.height10),
                decoration: BoxDecoration(
                  color: Get.theme.colorScheme.background,
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: Dimensions.width15,
                      right: Dimensions.width15,
                      top: Dimensions.height10,
                      bottom: Dimensions.height10),
                  child: DetailedCarteItemCard(item: item),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
