import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_number_game/Screen/auth/loginScreen.dart';
import 'package:my_number_game/Screen/homeScreen.dart';
import 'package:my_number_game/common/commonTost.dart';
import 'package:my_number_game/common/sharedPreference.dart';

class AuthController extends GetxController {
  final RxBool isLoading = false.obs;
  static String userId = '';
  static String userName = '';
  static int mobileNumber = 0;
  static var uidLoading = true.obs;
  GetUserDetail _userDetail = GetUserDetail();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void onInit() {
    load(); // Fetch data when the controller initializes
    super.onInit();
  }

  Future<void> signInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    isLoading.value = true;
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      String uid = userCredential.user!.uid;
      _userDetail.setUserData('Uid', uid);
      if (uid != null) {
        print(userCredential);
        CommonToast(
            context: context, title: 'Login Success', alignCenter: false);
        _userDetail.setUserData("Uid", uid);
        Get.off(HomeScreen());
      }
    } catch (e) {
      CommonToast(
          context: context,
          title: 'Enter a valid email and password',
          alignCenter: false);
      print("Error signing in: $e");
    }

    isLoading.value = false;
  }

/////////////////////////////user data from sharedfrefernce////////////////////////
  load() async {
    userId = await _userDetail.getUserData('Uid');
    Future.delayed(Duration(seconds: 1), () {
      uidLoading.value = false;
    });
  }

/////////////////////////////////////////signout////////////////////////////////
  Future<void> signOut() async {
    isLoading.value = true;
    try {
      await _auth.signOut();
      _userDetail.remove('Uid');
      Get.to(LoginScreen());
    } catch (e) {
      print("Error signing out: $e");
    }
    isLoading.value = false;
  }
}
