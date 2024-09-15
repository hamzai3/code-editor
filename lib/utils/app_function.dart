import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppFunctions {
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackbar({
    required BuildContext context,
    required String title,
    Duration duration = const Duration(milliseconds: 2000),
    SnackBarAction? action,
  }) {
    ScaffoldMessenger.of(context).clearSnackBars();
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(title),
        duration: duration,
        behavior: SnackBarBehavior.floating,
        action: action,
      ),
    );
  }

//2023-01-05T00: 00: 00.000Z to 05 Jan, 2023
  String dateTimeTZToDateStringFormat(String dateTime) {
    DateTime tempDate = DateFormat("yyyy-MM-ddTHH:mm:ss").parse(dateTime);
    return DateFormat('dd MMM, yyyy').format(tempDate);
  }

  String convert24hrToTimeString(String time) {
    return DateFormat("hh:mm a").format(DateFormat.Hm().parse(time));
  }

//2022-12-22 18:45 to 22 Dec 2022
  String dateTimeToDateStringFormat(String dateTime) {
    DateTime tempDate =
        DateFormat("yyyy-MM-dd HH:mm").parse(dateTime); //2022-12-22 18:45
    return DateFormat('dd MMM yyyy').format(tempDate);
  }

//2022-12-22 18:45 to 6:45 PM
  String dateTimeToTimeStringFormat(String dateTime) {
    DateTime tempDate = DateFormat("yyyy-MM-dd HH:mm").parse(dateTime);
    return DateFormat('hh:mm a').format(tempDate);
  }

//3:00 PM to 15:00
  String timeStringTo24HourFormat(String time) =>
      DateFormat("HH:mm").format(DateFormat.jm().parse(time));

//yyyy-MM-dd
  String dateFormatter(DateTime dateTime) {
    final DateFormat dateFormatter = DateFormat('yyyy-MM-dd');
    return dateFormatter.format(dateTime);
  }

//HH:mm
  String timeFormatter(DateTime dateTime) {
    final DateFormat timeFormatter = DateFormat('HH:mm');
    return timeFormatter.format(dateTime);
  }

//15:00 to 3:00 PM
  String timeFormatterAmPm(String time) {
    return DateFormat.jm().format(DateFormat("HH:mm").parse(time));
  }

//yyyy-MM-dd HH:mm'
  String dateTimeFormatter(DateTime dateTime) {
    final DateFormat dateTimeFormatter = DateFormat('yyyy-MM-dd HH:mm');
    return dateTimeFormatter.format(dateTime);
  }

  Future<String> getDeviceType() async {
    return Platform.isAndroid
        ? "Android"
        : Platform.isIOS
            ? "iOS"
            : "";
  }

  void dismissKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
}
