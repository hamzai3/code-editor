import 'package:code_editor/presentation/view/home_screens/home_screen.dart';
import 'package:code_editor/utils/app_colors.dart';
import 'package:code_editor/utils/app_img.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helpers/storage_helper.dart';
import '../../widget/logo_widget.dart';
import '../intro_screens/intro_slides.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    StorageHelper().getValue("userToken").then((userToken) {
      Future.delayed(const Duration(seconds: 3), () {
         
        if (userToken.toString().toLowerCase() == "null" || userToken.isEmpty) {
          Get.to(const IntroSlides());
        } else {
          Get.to(const HomeScreen());
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: progressBgColor,
        body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.bg),
                repeat: ImageRepeat.noRepeat,
                fit: BoxFit.cover,
              ),
            ),
            child: const Center(
              child: Hero(
                  tag: "logo_widget",
                  child: LogoWidget(
                    showName: false,
                  )),
            )));
  }
}
