import 'package:code_editor/controller/profile_controller.dart';
import 'package:code_editor/presentation/widget/divider_widget.dart';
import 'package:code_editor/utils/app_globle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../models/graph_model.dart';
import '../../widget/app_bar_widget.dart';
import '../../widget/bottom_bar_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (controller) {
          return Scaffold(
            key: UniqueKey(),
            backgroundColor: Colors.black,
            bottomNavigationBar: BottomNavWidget(
              currentIndex: 1,
            ),
            body: AppBarWidget(
                onTapPopup: () {
                  controller.confirmLogut(context);
                },
                trailingText: "logout",
                title: "Profile",
                key: UniqueKey(),
                child: Container(
                    color: Colors.black,
                    height: deviceHeight * 0.9,
                    // padding: EdgeInsets.only(top: deviceHeight*0.1),
                    child: ListView(
                      key: UniqueKey(),
                      children: [
                        DividerWidget(
                          height: deviceHeight * 0.1,
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(controller
                                  .photoUrl), // Replace with your network image URL
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        // Name and email at the bottom
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                controller.displayName,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                controller.email,
                                style:
                                    const TextStyle(fontSize: 16, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: deviceWidth,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SfCartesianChart(
                              primaryXAxis: const CategoryAxis(
                                name:
                                    '{value}', // Display the language names as is
                              ),
                              primaryYAxis: const NumericAxis(
                                  interval: 5), // Keep the same

                              series: <CartesianSeries>[
                                ColumnSeries<ChartData, String>(
                                  // Change to ColumnSeries for bar graph
                                  dataSource: controller.chartData,
                                  xValueMapper: (ChartData data, _) =>
                                      data.lang, // Map language to x-axis
                                  yValueMapper: (ChartData data, _) =>
                                      data.y, // Map count to y-axis
                                ),
                              ],
                              // primaryXAxis: const DateTimeAxis(
                              //   interval: 30, // Set the interval to 10 days
                              // ),
                              // primaryYAxis: const NumericAxis(interval: 5), // Set the interval to 5

                              // series: <CartesianSeries>[
                              //   LineSeries<ChartData, DateTime>(
                              //     dataSource: _chartData,
                              //     xValueMapper: (ChartData data, _) => data.x,
                              //     yValueMapper: (ChartData data, _) => data.lang,
                              //   ),
                              // ],
                            ),
                          ),
                        ),
                      ],
                    ))),
          );
        });
  }
}
