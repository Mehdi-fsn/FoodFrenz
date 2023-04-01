import 'package:flutter/material.dart';
import 'package:foodfrenz/app/core/utils/dimensions.dart';
import 'package:get/get.dart';

class AppIcon extends StatelessWidget {
  const AppIcon(
      {Key? key, required this.icon, required this.onTap, this.size = 40})
      : super(key: key);

  final IconData icon;
  final double size;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap as void Function()?,
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          color: Get.isDarkMode ? Colors.black54 : const Color(0xFFfcf4e4),
          borderRadius: BorderRadius.circular(size / 2),
        ),
        child: Icon(
          icon,
          color: Get.isDarkMode ? Colors.white : const Color(0xFF756d54),
          size: Dimensions.iconSizeSmall,
        ),
      ),
    );
  }
}
