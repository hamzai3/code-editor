import 'package:code_editor/controller/home_controller.dart';
import 'package:code_editor/presentation/widget/app_bar_widget.dart';
import 'package:code_editor/presentation/widget/bottom_bar_widget.dart';
import 'package:code_editor/utils/app_colors.dart';
import 'package:code_editor/utils/app_function.dart';
import 'package:code_editor/utils/app_globle.dart';
import 'package:code_text_field/code_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';

import '../../../utils/text_style.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          return Scaffold(
            key: controller.pagesViewScaffoldKey,
            backgroundColor: Colors.black,
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                AppFunctions().dismissKeyboard(context);
                controller.executeCode(controller.controller.text, context);
              },
              child: const Icon(Icons.play_arrow_outlined,size: 32,),
            ), 
            bottomNavigationBar: BottomNavWidget(
              currentIndex: 0,
            ),
            body: AppBarWidget(
                onTapPopup: () {
                  controller.showLanguageVersionDialog(context);
                },
                trailingText: controller.selectedLanguage.toString(),
                title: "Code",
                key: UniqueKey(),
                child: Container(
                    color: Colors.black,
                    height: deviceHeight * 0.9,
                    // padding: EdgeInsets.only(top: deviceHeight*0.1),
                    child: ListView(
                      children: [
                        SizedBox(
                          height: deviceHeight * 0.7,
                          child: CodeTheme(
                            data: const CodeThemeData(
                              styles: monokaiSublimeTheme,
                            ),
                            child: SingleChildScrollView(
                              child: CodeField(
                                wrap: false,
                                controller: controller.controller,
                                // minLines: 100,
                              ),
                            ),
                          ),
                        ),
                        controller.output != ''
                            ? Padding(
                                padding: const EdgeInsets.all(18),
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      border: Border.all(
                                        color: Colors.green,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    // height: deviceHeight * 0.08,
                                    padding: const EdgeInsets.all(10),
                                    width: deviceWidth * 0.8,
                                    child: Text(
                                      "Output: ${controller.output}",
                                      style: TextStyles.smallText
                                          .copyWith(color: whiteColor),
                                    )),
                              )
                            : Container(),
                      ],
                    ))),
          );
        });
  }
}
