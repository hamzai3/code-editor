import 'package:code_editor/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'app_globle.dart';

class TextStyles {
  // fonnt sie :20
  static TextStyle buttonText = TextStyle(
      fontSize: deviceHeight * 0.1, color: whiteColor, fontFamily: "Mont");

  static TextStyle largerText = TextStyle(
      fontSize: deviceHeight * 0.1, color: textColor, fontFamily: "Mont");

  static TextStyle largeText = TextStyle(
      fontSize: deviceHeight * 0.03, color: textColor, fontFamily: "Mont");

  static TextStyle mediumText = TextStyle(
      fontSize: deviceHeight * 0.1, color: whiteColor, fontFamily: "Mont");

  static TextStyle smallText = TextStyle(
      fontSize: deviceHeight * 0.02,
      color: textColor.withOpacity(0.7),
      fontFamily: "Mont");
  static TextStyle smallerText = TextStyle(
      fontSize: deviceHeight * 0.018, color: whiteColor, fontFamily: "Mont");

  static TextStyle smallestText = TextStyle(
      fontSize: deviceHeight * 0.1, color: textColor, fontFamily: "Mont");
}
