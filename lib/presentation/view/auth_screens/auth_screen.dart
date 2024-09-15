import 'package:code_editor/presentation/view/home_screens/home_screen.dart';
import 'package:code_editor/presentation/widget/button_widget.dart';
import 'package:code_editor/presentation/widget/divider_widget.dart';
import 'package:code_editor/utils/app_globle.dart';
import 'package:code_editor/utils/app_img.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/auth_controller.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
        init: AuthController(),
        builder: (authController) {
          return Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.bg),
                repeat: ImageRepeat.noRepeat,
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AppImages.auth),
                DividerWidget(
                  height: deviceHeight * 0.1,
                ),
                PrimaryButtonWidget(
                  title: "Continue With Google",
                  onTap: () {
                    authController.signInWithGoogle();
                  },
                  suffixIcon: Image.asset(
                    AppImages.google,
                    width: deviceWidth * 0.1,
                  ),
                ),
                DividerWidget(
                  height: deviceHeight * 0.05,
                ),
                SecondaryButtonWidget(
                  title: "Skip",
                  onTap: () {
                    Get.to(const HomeScreen());
                  },
                )
              ],
            ),
          );
        });
  }
}
