 
import 'package:code_editor/presentation/view/auth_screens/auth_screen.dart';
import 'package:code_editor/utils/app_globle.dart';
import 'package:code_editor/utils/app_img.dart';
import 'package:code_editor/utils/app_strings.dart';
import 'package:get/get.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:flutter/material.dart';

import '../../../utils/text_style.dart';

class IntroSlides extends StatefulWidget {
  const IntroSlides({super.key});

  @override
  State<IntroSlides> createState() => _IntroSlidesState();
}

class _IntroSlidesState extends State<IntroSlides> {
  List<ContentConfig> listContentConfig = [];

  @override
  void initState() {
    super.initState();

    listContentConfig.add(
      ContentConfig(
        title: AppStrings.introText1,
        heightImage: deviceHeight * 0.3,
        styleTitle: TextStyles.largeText,

        styleDescription: TextStyles.smallText,
        description: AppStrings.introDesc1,
        pathImage: AppImages.introOne,
        // backgroundColor: Color(0xfff5a623),
      ),
    );
    listContentConfig.add(
      ContentConfig(
        title: AppStrings.introText2,
        styleTitle: TextStyles.largeText,
        heightImage: deviceHeight * 0.3,
        styleDescription: TextStyles.smallText,
        description: AppStrings.introDesc2,
        pathImage: AppImages.introTwo,
        // backgroundColor: Color(0xff203152),
      ),
    );
    listContentConfig.add(
      ContentConfig(
        title: AppStrings.introText3,
        styleTitle: TextStyles.largeText,
        heightImage: deviceHeight * 0.3,

        styleDescription: TextStyles.smallText,
        description: AppStrings.introDesc3,
        pathImage: AppImages.introThree,
        // backgroundColor: Color(0xff9932CC),
      ),
    );
  }

  void onDonePress() { 
    Get.to(const AuthScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.bg),
          repeat: ImageRepeat.noRepeat,
          fit: BoxFit.cover,
        ),
      ),
      child: IntroSlider(
        key: UniqueKey(),
        listContentConfig: listContentConfig,
        onDonePress: onDonePress,
      ),
    );
  }
}
