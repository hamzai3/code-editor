import 'package:code_editor/utils/app_colors.dart';
import 'package:code_editor/utils/app_dimen.dart';
import 'package:flutter/material.dart';
 
class AppTheme {
  static final light = ThemeData.light().copyWith(
      appBarTheme: AppBarTheme(
        centerTitle: true,
        titleTextStyle: getTextStyle(
          color: Colors.black,
          size: FontDimen.dimen24,
          fontWeight: FontWeight.w600,
        ),
        shadowColor: Colors.transparent.withOpacity(0.0),
        backgroundColor:
            Colors.transparent.withOpacity(0.0), // Color.fromARGB(0, 0, 0, 0),
        elevation: 0,

        surfaceTintColor: Colors.transparent.withOpacity(0.0),
        foregroundColor: Colors.transparent.withOpacity(0.0),
        iconTheme: const IconThemeData(
          color: whiteColor,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          textStyle: WidgetStateTextStyle.resolveWith(
            (states) => getTextStyle(
              color: primaryColor,
            ),
          ),
        ),
      ),
      primaryColor: primaryColor,
      scaffoldBackgroundColor: Colors.white,
      iconTheme: const IconThemeData(color: whiteColor),
      cardColor: whiteColor,
      hintColor: micsGrey,
      dividerColor: const Color.fromRGBO(0, 0, 0, 1),
      textTheme: TextTheme(
        displayLarge: getTextStyle(
          color: whiteColor,
          size: FontDimen.dimen24,
          fontWeight: FontWeight.w600,
          //fontFamily: "Mont",
        ),
        displayMedium: getTextStyle(
          color: Colors.black,
          size: FontDimen.dimen16,
          fontWeight: FontWeight.w500,
          // fontFamily: "Mont",
        ),
        displaySmall: getTextStyle(
          color: Colors.black,
          size: FontDimen.dimen16,
          fontWeight: FontWeight.w700,
          // fontFamily: "Mont",
        ),
        headlineLarge: getTextStyle(
          color: redColor,
          size: FontDimen.dimen16,
          fontWeight: FontWeight.w500,
          // fontFamily: "Mont",
        ),
        headlineMedium: getTextStyle(
          color: whiteColor,
          size: FontDimen.dimen16,
          fontWeight: FontWeight.w700,
          // fontFamily: "Mont",
        ),
        headlineSmall: getTextStyle(
          color: Colors.black,
          size: FontDimen.dimen14,
          fontWeight: FontWeight.w600,
          // fontFamily: "Mont",
        ),
        titleLarge: getTextStyle(
          color: primaryColor,
          size: FontDimen.dimen24,
          fontWeight: FontWeight.w700,
          // fontFamily: "Mont",
        ),
        titleMedium: getTextStyle(
          color: textColor,
          size: FontDimen.dimen14,
          fontWeight: FontWeight.w400,
          // fontFamily: "Mont",
        ),
        titleSmall: getTextStyle(
          color: textColor,
          size: FontDimen.dimen13,
          fontWeight: FontWeight.w400,
          // fontFamily: "Mont",
        ),
        labelLarge: getTextStyle(
          color: redColor,
          size: FontDimen.dimen14,
          fontWeight: FontWeight.w500,
          fontFamily: "Mont",
        ),
        labelMedium: getTextStyle(
          color: Colors.black,
          size: FontDimen.dimen16,
          fontWeight: FontWeight.w700,
        ),
        labelSmall: getTextStyle(
          color: redColor,
          size: FontDimen.dimen12,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: getTextStyle(
          color: whiteColor,
          size: FontDimen.dimen18,
          fontWeight: FontWeight.w700,
        ),
        bodyMedium: getTextStyle(
          color: redColor,
          size: FontDimen.dimen12,
          fontWeight: FontWeight.w400,
        ),
        bodySmall: getTextStyle(
          color: redColor,
          size: FontDimen.dimen14,
          fontWeight: FontWeight.w300,
        ),
      ));
}

TextStyle getTextStyle(
        {FontWeight? fontWeight,
        String? fontFamily,
        Color? color,
        double? size}) =>
    TextStyle(
      color: color ?? textColor,
      fontSize: size ?? 12,
      fontWeight: fontWeight ?? FontWeight.w500,
      // letterSpacing: 0.30,
      // height: 1.2,
      fontFamily:"Mont",
    );
