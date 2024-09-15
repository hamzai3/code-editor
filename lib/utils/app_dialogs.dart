import 'package:code_editor/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../presentation/widget/loading_widget.dart';
import 'app_colors.dart';

class AppDialogs {
  static successSnackBar(String msg) {
    if (msg.isNotEmpty) {
      return ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
            backgroundColor: Colors.green,
            content: Text(msg,
                style: TextStyles.smallText.copyWith(color: Colors.white))),
      );
    }
  }

  static errorSnackBar(String msg) {
    if (msg.isNotEmpty) {
      return ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
            backgroundColor: redColor,
            content: Text(msg,
                style: TextStyles.smallText.copyWith(color: Colors.white))),
      );
    }
  }

  static showProcess() {
    return Get.dialog(
      barrierDismissible: false,
      const AlertDialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          content: PopScope(canPop: false, child: LoadingWidget())),
    );
  }
}
