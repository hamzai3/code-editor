import 'package:code_editor/presentation/view/home_screens/home_screen.dart';
import 'package:code_editor/presentation/view/profile_screen/profile_screen.dart';
import 'package:code_editor/utils/app_colors.dart';
import 'package:code_editor/utils/app_img.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavWidget extends StatelessWidget {
  final int currentIndex;
  BottomNavWidget({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          activeIcon: Image.asset(
            AppImages.play,
            width: 50,
          ),
          icon: Image.asset(
            AppImages.inplay,
            width: 50,
          ),
          label: 'Code',
        ),
        BottomNavigationBarItem(
          activeIcon: Image.asset(
            AppImages.gear,
            width: 50,
          ),
          icon: Image.asset(
            AppImages.ingear,
            width: 50,
          ),
          label: 'Profile',
        ),
      ],
      currentIndex: currentIndex,
      selectedItemColor: primaryColor,
      onTap: (selectedIndex) {
        if (selectedIndex != currentIndex && selectedIndex == 0) {
          Get.to(const HomeScreen());
        } else if (selectedIndex != currentIndex && selectedIndex == 1) {
          Get.to(const ProfileScreen());
        }
      },
    );
  }
}
