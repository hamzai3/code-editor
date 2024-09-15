import 'package:code_editor/utils/app_globle.dart';
import 'package:code_editor/utils/app_theme.dart';
import 'package:code_editor/presentation/view/splash_screen/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyAppp2U2iPMeDjtNQgqbyiljWFbzogYGkU',
    appId: 'com.hamza.code_editor',
    messagingSenderId: '1068887994090',
    projectId: 'share-chat-b8795',
    storageBucket: 'share-chat-b8795.appspot.com',
  ));
    await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const SplashScreen(),
    );
  }
}
