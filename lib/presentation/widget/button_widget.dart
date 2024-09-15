import 'package:code_editor/utils/app_colors.dart';
import 'package:code_editor/utils/app_globle.dart';
import 'package:flutter/material.dart';

import '../../utils/text_style.dart';

class PrimaryButtonWidget extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final Widget? suffixIcon;
  const PrimaryButtonWidget(
      {super.key, required this.title, required this.onTap, this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: deviceWidth * 0.7,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.green, // Button background color
        borderRadius: BorderRadius.circular(8.0), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.green.shade900, // Shadow color
            offset: const Offset(0, 3), // Shadow position
            blurRadius: 5, // How blurry the shadow should be
            spreadRadius: 1, // How much shadow should spread
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MaterialButton(
            onPressed: onTap,
            child: Text(title.toString(),
                style: TextStyles.smallText.copyWith(color: Colors.white)),
          ),
          suffixIcon ?? Container(),
        ],
      ),
    );
  }
}

class SecondaryButtonWidget extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final Widget? suffixIcon;
  const SecondaryButtonWidget(
      {super.key, required this.title, required this.onTap, this.suffixIcon});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: deviceWidth * 0.7,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white, // Button background color
        borderRadius: BorderRadius.circular(8.0), // Rounded corners
        border: Border.all(
          color: primaryColor, // Border color for the SKIP button
          width: 2.0, // Border width
        ),
      ),
      child: MaterialButton(
        onPressed: () {
          // Button on press action
        },
        child: Text(
          title.toString(),
          style: TextStyles.smallText.copyWith(color: primaryColor),
        ),
      ),
    );
  }
}
