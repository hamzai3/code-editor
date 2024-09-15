import 'package:code_editor/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/text_style.dart';

class AppBarWidget extends StatelessWidget {
  final Widget child;
  VoidCallback onTapPopup;
  final String title, trailingText;
  AppBarWidget(
      {super.key,
      required this.child,
      required this.onTapPopup,
      required this.title,
      required this.trailingText});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        key: UniqueKey(),
        navigationBar: CupertinoNavigationBar(
          backgroundColor: primaryColor,
          automaticallyImplyLeading: false,
          middle: Text(
            title,
            style: TextStyles.smallText
                .copyWith(color: whiteColor, fontWeight: FontWeight.bold),
          ), // App Title in the middle
          trailing: trailingText == "logout"
              ? GestureDetector(
                  onTap: onTapPopup,
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        CupertinoIcons.square_arrow_left,
                        color: CupertinoColors.white,
                        size: 18.0,
                      )
                    ],
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                    color: Colors.white, // Button background color
                    borderRadius: BorderRadius.circular(8.0), // Rounded corners
                    border: Border.all(
                      color: primaryColor, // Border color for the SKIP button
                      width: 2.0, // Border width
                    ),
                  ),
                  padding: const EdgeInsets.all(5),
                  child: GestureDetector(
                    onTap: onTapPopup,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          trailingText,
                          style: TextStyles.smallerText
                              .copyWith(color: CupertinoColors.activeBlue),
                        ),
                        const Icon(
                          CupertinoIcons.arrowtriangle_down,
                          color: CupertinoColors.activeBlue,
                          size: 18.0,
                        )
                      ],
                    ),
                  ),
                ),
        ),
        child: Padding(
          // padding: EdgeInsets.only(top: deviceHeight * 0.1),
          padding: const EdgeInsets.only(top: 1),
          child: child,
        ));
  }
}
