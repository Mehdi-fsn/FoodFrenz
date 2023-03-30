import 'package:flutter/material.dart';
import 'package:foodfrenz/app/core/utils/dimensions.dart';

class IconAndTextWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color textColor;
  final double textSize;
  final Color iconColor;
  final double iconSize;

  const IconAndTextWidget({
    Key? key,
    required this.icon,
    required this.text,
    required this.textColor,
    required this.textSize,
    required this.iconColor,
    required this.iconSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: iconColor,
          size: iconSize,
        ),
        SizedBox(width: Dimensions.width3),
        Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: textSize,
          ),
        ),
      ],
    );
  }
}
