// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_number_game/Screen/accountBalance.dart';
import 'package:my_number_game/Screen/contestList.dart';
import 'package:my_number_game/common/commonTost.dart';

// ignore: camel_case_types
class joinContest extends GetxController {
  var isloading = false.obs;
  int currentHour = DateTime.now().hour;
  var contestid = ''.obs;

  final FirebaseFirestore instance = FirebaseFirestore.instance;
  int currentDepositAmount = 0;
  int currentWiningAmount = 0;

  Future<void> jointcontest(
      String gameType,
      String contesId,
      int Number,
      int Amount,
      int winingAmount,
      int depositAmount,
      BuildContext context,
      int mobileNumber,
      String uid) async {
    isloading.value = true;

    try {
      print(" clicked");
      var response = await instance
          .collection("Contest")
          .doc(gameType)
          .collection(contesId)
          .doc()
          .set({
        "Number": Number,
        "Amount": Amount,
        "UserId": uid,
        "JoinTime": DateTime.now(),
        'Mobile Number': 7439064216,
        'name': 'Rittik Mondal',
        'isWin': false,
        'isReal': true
      }).then(
        (value) {
          Navigator.pop(context);
          CommonToast(
              context: context,
              title: "Join contest Successfully",
              alignCenter: false);
        },
      ).then(
        (value) {
          Future.delayed(const Duration(microseconds: 3000), () {
            calCulatecurrentBalance(Amount, depositAmount, winingAmount);
            updateUserData(uid, currentDepositAmount, currentWiningAmount);

            isloading.value = false;
            Get.to(ContestList(gameType: gameType, contestId: contesId));
          });
        },
      );
    } catch (e) {
      debugPrint("Error occoured" + e.toString());
      CommonToast(
          context: context,
          title: 'Something went wrong try again letter',
          alignCenter: false);
      Navigator.pop(context);
    }
    isloading.value = false;
  }

//////////////////////////update user Balance////////////////////////////////
  Future<void> updateUserData(
      String userId, int newDepositAmount, int newWiningAmount) async {
    try {
      // Reference to the document in the "User" collection with the given userId
      DocumentReference userRef =
          FirebaseFirestore.instance.collection("User").doc(userId);

      // Use update() to modify specific fields without overwriting the entire document
      await userRef.update({
        'Deposit': newDepositAmount,
        'Wining': newWiningAmount,
      });
      print("Balance deduct successfully.");
    } catch (e) {
      print("Error balance update user data: $e");
    }
  }

/////////////////////////////calculate Balance//////////////////////////
  void calCulatecurrentBalance(
      int betAmount, int depositAmount, int winingAmount) {
    currentDepositAmount = depositAmount;
    currentWiningAmount = winingAmount;
    if (betAmount <= depositAmount) {
      currentDepositAmount = depositAmount - betAmount;
    } else {
      currentDepositAmount = 0;
      currentWiningAmount = winingAmount - (betAmount - depositAmount);
    }
  }
}
