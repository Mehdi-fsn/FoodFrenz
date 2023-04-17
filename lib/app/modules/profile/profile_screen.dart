import 'package:flutter/material.dart';
import 'package:foodfrenz/app/core/constant/constants.dart';
import 'package:foodfrenz/app/core/theme/colors.dart';
import 'package:foodfrenz/app/core/utils/dimensions.dart';
import 'package:foodfrenz/app/modules/profile/profile_controller.dart';
import 'package:foodfrenz/app/modules/profile/widgets/global_information_view.dart';
import 'package:foodfrenz/app/modules/profile/widgets/settings_view.dart';
import 'package:get/get.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: Dimensions.width15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    Constants.profile,
                    style: TextStyle(
                        color: Get.isDarkMode
                            ? AppColors.mainDarkColor
                            : AppColors.mainColor,
                        fontSize: Dimensions.textSize30,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    width: Dimensions.height45,
                    height: Dimensions.height45,
                    decoration: BoxDecoration(
                      color: Get.isDarkMode
                          ? AppColors.mainDarkColor
                          : AppColors.mainColor,
                      borderRadius: BorderRadius.circular(Dimensions.radius10),
                    ),
                    child: Icon(Icons.edit,
                        color: Get.isDarkMode ? Colors.black87 : Colors.white),
                  ),
                ],
              ),
              const GlobalInformationView(),
              SizedBox(height: Dimensions.height15),
              const SettingsView(),
            ],
          ),
        ),
      ),
    );
  }
}
