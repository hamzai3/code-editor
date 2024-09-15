import 'dart:developer';

import 'package:code_editor/presentation/view/home_screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../helpers/storage_helper.dart';
import '../utils/app_dialogs.dart';

class AuthController extends GetxController {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        final User? user = userCredential.user;

        // Now you have access to user properties:
        var email = user?.email;
        var displayName = user?.displayName;
        var photoUrl = user?.photoURL;
        StorageHelper().setValue("userEmail", email!);
        StorageHelper().setValue("userName", displayName!);
        StorageHelper().setValue("userPic", photoUrl!);
        var token = user!.uid.toString();
        StorageHelper().setValue("userToken", token);

        update();
        // Use this information as needed!

        AppDialogs.successSnackBar("Completed, please wait");
        Get.to(() => const HomeScreen());
      } else {
        AppDialogs.errorSnackBar("Cancelled");
      }
    } catch (e, stackTrace) {
      log("$e, $stackTrace");
      // Handle sign-in errors
    }
  }
}
