import 'package:flutter/cupertino.dart'; 

import '../../utils/app_img.dart';
import 'divider_widget.dart';

class LogoWidget extends StatelessWidget {
  final double? imageHeight;
  final double? textHeight;
  final bool? showName;

  const LogoWidget(
      {super.key,
      this.imageHeight = 160,
      this.textHeight = 40,
      this.showName = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(AppImages.logo,
            height: imageHeight),
        showName != null && showName! ? const DividerWidget(height: 20) : const SizedBox(),
        showName != null && showName!
            ? Image.asset(
                "asset/images/logo_name.png",
                height: textHeight,
              )
            : const SizedBox(),
      ],
    );
  }
}
