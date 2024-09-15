
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_editor/helpers/storage_helper.dart';
import 'package:code_editor/presentation/view/auth_screens/auth_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/graph_model.dart';

class ProfileController extends GetxController {
  var pagesViewScaffoldKey = GlobalKey<ScaffoldState>();
  List<ChartData> chartData = [];

  var email = '';
  var displayName = '';
  var photoUrl = ''; 
  Future<List<ChartData>> fetchChartData() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    
    
    var snapShotsValue = await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("lanugageCounts")
        .get();

    List<ChartData> chartData = [];

    snapShotsValue.docs.forEach((doc) {
      doc.data().forEach((date, languageCounts) {
        
        var newDate =
            "${doc.id.split("-")[0].toString()}-${doc.id.split("-")[1].padLeft(2, "0").toString()}-${doc.id.split("-")[2].toString()}";

        
        chartData.add(ChartData(
            x: DateTime.parse(newDate),
            y: int.parse(languageCounts),
            lang: date)); // Assuming 'language' is the language name
      });
    });

    return chartData;
  }

  confirmLogut(context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            CupertinoDialogAction(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              child: const Text('Logout'),
              onPressed: () {
                Navigator.of(context).pop();
                StorageHelper().setValue("userToken", "null");
                FirebaseAuth.instance.signOut();
                Get.to(const AuthScreen());
                // Add your logout logic here
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void onInit() {
    super.onInit();
    fetchChartData().then((data) {
      chartData = data;
      update();
    });

    StorageHelper().getValue("userEmail").then((value) {
      email = value;
      update();
    });
    StorageHelper().getValue("userName").then((value) {
      displayName = value;
      update();
    });
    StorageHelper().getValue("userPic").then((value) {
      photoUrl = value;
      update();
    });
  }
}
