import 'package:flutter/material.dart';
import 'package:foodfrenz/app/core/utils/dimensions.dart';

class ChipWidget extends StatelessWidget {
  const ChipWidget(
      {Key? key, required this.label, required this.backgroundColor})
      : super(key: key);

  final String label;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Chip(
      side: BorderSide(color: backgroundColor),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimensions.radius20),
      ),
      backgroundColor: backgroundColor,
      label: Text(
        label,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
