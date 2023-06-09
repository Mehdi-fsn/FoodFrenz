import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodfrenz/app/core/theme/colors.dart';
import 'package:foodfrenz/app/core/utils/dimensions.dart';
import 'package:foodfrenz/app/core/utils/time_difference.dart';
import 'package:foodfrenz/app/modules/profile/profile_controller.dart';
import 'package:get/get.dart';

class GlobalInformationView extends GetView<ProfileController> {
  const GlobalInformationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.userChanges.value != null
          ? Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      height: Dimensions.height110,
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Dimensions.width10,
                                  vertical: Dimensions.height10),
                              child: CachedNetworkImage(
                                imageUrl:
                                    controller.userChanges.value!.photoURL ??
                                        '',
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius15),
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                placeholder: (context, url) =>
                                    const SizedBox.shrink(),
                                errorWidget: (context, url, error) => Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius15),
                                    color: Get.isDarkMode
                                        ? AppColors.mainDarkColor
                                        : AppColors.mainColor,
                                  ),
                                  child: Icon(
                                    Icons.person,
                                    size: Dimensions.iconSize30,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                                right: 0,
                                bottom: 0,
                                child: GestureDetector(
                                  onTap: () => controller.uploadProfileImage(),
                                  child: Container(
                                    width: Dimensions.width30,
                                    height: Dimensions.width30,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[400],
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.edit,
                                      size: Dimensions.iconSizeSmall,
                                      color: Colors.white,
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: Dimensions.width15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.userChanges.value!.displayName ??
                              controller.userChanges.value!.email!
                                  .split('@')
                                  .first,
                          style: TextStyle(
                            color: Get.theme.colorScheme.onBackground,
                            fontSize: Dimensions.textSizeLarge,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          controller.userChanges.value!.email!,
                          style: TextStyle(
                            color: AppColors.paraColor,
                            fontSize: Dimensions.textSizeSmall,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: Dimensions.width15),
                  height: Dimensions.height70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildRichText(
                        timeDifference(controller.userInfo.value.createdAt),
                        'Member Since',
                      ),
                      _buildRichText(
                        controller.userInfo.value.transactions.toString(),
                        'Transactions',
                      ),
                      _buildRichText(
                        '\$${controller.userInfo.value.spending.toStringAsFixed(2)}',
                        'Spending',
                      ),
                    ],
                  ),
                )
              ],
            )
          : const SizedBox.shrink(),
    );
  }

  Widget _buildRichText(String text1, String text2) {
    return RichText(
      textAlign: TextAlign.start,
      text: TextSpan(
        children: [
          TextSpan(
            text: text1,
            style: TextStyle(
              color: Get.theme.colorScheme.onBackground,
              fontSize: Dimensions.textSizeMedium,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: '\n$text2',
            style: TextStyle(
              color: AppColors.paraColor,
              fontSize: Dimensions.textSizeSmall,
            ),
          ),
        ],
      ),
    );
  }
}
