import 'package:flutter/material.dart';
import 'package:foodfrenz/app/core/constant/constants.dart';
import 'package:foodfrenz/app/core/theme/colors.dart';
import 'package:foodfrenz/app/core/utils/dimensions.dart';
import 'package:get/get.dart';

class ExpandableTextWidget extends StatefulWidget {
  const ExpandableTextWidget({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  State<ExpandableTextWidget> createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  late String _firstHalf;
  late String _secondHalf;

  bool _hideText = true;

  double textHeight = Dimensions.screenHeight / 5;

  @override
  void initState() {
    super.initState();
    if (widget.text.length > textHeight) {
      _firstHalf = widget.text.substring(0, textHeight.toInt());
      _secondHalf =
          widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      _firstHalf = widget.text;
      _secondHalf = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _secondHalf.isEmpty
          ? Text(_firstHalf,
              style: TextStyle(
                color: Get.isDarkMode ? Colors.white : AppColors.paraColor,
                fontSize: Dimensions.textSizeDefault,
              ))
          : Column(
              children: [
                Text(
                  _hideText ? "$_firstHalf..." : _firstHalf + _secondHalf,
                  style: TextStyle(
                    color: Get.isDarkMode ? Colors.white : AppColors.paraColor,
                    fontSize: Dimensions.textSizeDefault,
                  ),
                ),
                SizedBox(height: Dimensions.height5),
                InkWell(
                  onTap: () {
                    setState(() {
                      _hideText = !_hideText;
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        _hideText ? Constants.showMore : Constants.showLess,
                        style: const TextStyle(
                          color: AppColors.mainColor,
                          fontSize: 16,
                        ),
                      ),
                      Icon(
                        _hideText
                            ? Icons.keyboard_arrow_down_rounded
                            : Icons.keyboard_arrow_up_rounded,
                        color: AppColors.mainColor,
                      )
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
