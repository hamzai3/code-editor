import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageHelper {
  get storage => GetStorage();

  removeUser() async {
    await storage.erase();
    await Get.deleteAll();
    // Get.offAll(() => JoinScreen());
    // await storage.remove('isLoggedIn');
    // await storage.remove('loginData');
  }

  setValue(key, value) async {
    const storage = FlutterSecureStorage();
    // Write value
    storage.write(key: key, value: value).toString();
  }
 
  Future<String> getValue(key) async {
    return await read(key).then((ret) {
      log(ret.toString());
      return ret.toString();
    });
  }

  Future read(String storageName) async {
    const storage = FlutterSecureStorage();
    return storage.read(key: storageName);
  }

  set isLoggedIn(bool value) => storage.write("isLoggedIn", value);
  bool get isLoggedIn => storage.read('isLoggedIn') ?? false;

  set isGuest(bool value) => storage.write("isGuest", value);
  bool get isGuest => storage.read("isGuest") ?? false;
  set verificationID(String value) => storage.write("verificationID", "NULL");
  String get verificationID => storage.read("verificationID") ?? "NULL";
  set userEmail(String value) => storage.write("userEmail", "NULL");
  String get userEmail => storage.read("userEmail") ?? "NULL";
  set userName(String value) => storage.write("userName", "NULL");
  String get userName => storage.read("userName") ?? "NULL";
  set userPic(String value) => storage.write("usePic", "NULL");
  String get userPic => storage.read("userPic") ?? "NULL";
  set userToken(String value) => storage.write("userToken", "NULL");
  String get userToken => storage.read("userToken") ?? "NULL";

  // set isRegiUser(bool value) => storage.write("isRegiUser", value);
  // bool get isRegiUser => storage.read('isRegiUser') ?? false;

  // set isLevelCom(bool value) => storage.write("isLevelCom", value);
  // bool get isLevelCom => storage.read('isLevelCom') ?? false;
}
