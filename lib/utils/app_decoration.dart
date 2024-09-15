import 'package:code_editor/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AppDecoration {
  static cardDecoration(
          {BorderRadiusGeometry? borderRadius,
          Color? borderColor,
          Color? bgColor,
          List<BoxShadow>? boxShadowx,
          DecorationImage? image}) =>
      BoxDecoration(
        image: image,
        boxShadow: boxShadowx,
        borderRadius: borderRadius ?? BorderRadius.circular(15),
        color: bgColor ?? Colors.transparent,
        border:
            Border.all(color: borderColor ?? Colors.transparent, width: 1.0),
      );

  // // BoxDecoration(
  // //     color: Get.theme.cardColor,
  // //     borderRadius:
  // //         borderRadius ?? BorderRadius.circular(Appdimens.dimen20),
  // //     boxShadow: [
  // //       con.BoxShadow(
  // //         blurRadius: 1.0,
  // //         inset: true,
  // //         offset: const Offset(0, -4),
  // //         color: primaryColor.withOpacity(0.25),
  // //       )
  // //     ]);

  static BoxShadow boxShadow({Color? color}) => BoxShadow(
        color: color ?? primaryColor.withOpacity(0.3),
        spreadRadius: 0,
        blurRadius: 6,
        offset: const Offset(0, 4),
      );

  static BoxDecoration btnDecoration(
          {Color? color,
          BorderRadiusGeometry? borderRadius,
          Color? shadowColor}) =>
      BoxDecoration(
          color: color ?? primaryColor,
          borderRadius: borderRadius ?? BorderRadius.circular(15),
          boxShadow: [
            boxShadow(color: shadowColor),
          ]);

  static BoxDecoration imgDecoration(String img) => BoxDecoration(
        image: DecorationImage(
            image: AssetImage(
              img,
            ),
            fit: BoxFit.cover),
      );
  static BoxDecoration foregroundOpacityDecoration(
          {BorderRadiusGeometry? borderRadius}) =>
      BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.circular(10),
        color: Colors.white.withOpacity(0.3),
      );
}
