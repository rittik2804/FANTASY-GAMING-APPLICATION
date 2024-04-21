import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_number_game/Screen/accountBalance.dart';
import 'package:my_number_game/Screen/contest/gold.dart';
import 'package:my_number_game/Screen/drawer.dart';
import 'package:my_number_game/Screen/contest/silver.dart';
import 'package:my_number_game/constant/constant.dart';
import 'package:my_number_game/controller/ResultCont.dart';
import 'package:my_number_game/controller/authCont/loginCont.dart';
import 'package:my_number_game/controller/fethDataControler.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthController _authController = AuthController();
  final UserController userController = Get.put(UserController());

  String name = '';
  RxString contestNum = 'Silver'.obs;
  @override
  void initState() {
    _authController.load().then((value) {
      if (AuthController.userId != '') {
        userController.fetchUser(AuthController.userId);
      }
    }).catchError((error) {
      debugPrint('Error occurred: $error');
    });
    print(AuthController.userName);
    print(AuthController.userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: kDrawer(),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: primaryColor),
          title: const Text(
            "OneCash",
            style: appbarTextStyle,
          ),
          backgroundColor: deepBacgroundColor,
          actions: [
            InkWell(
              onTap: () {
                if (AuthController.userId != '') {
                  Get.to(AccountBalance(uid: AuthController.userId));
                }
              },
              child: Container(
                //padding: kPrimaryPadding,
                margin: kPrimaryPadding,
                decoration: BoxDecoration(
                    color: secondaryyColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          if (AuthController.userId != '') {
                            Get.to(AccountBalance(uid: AuthController.userId));
                          }
                        },
                        icon: const Icon(Icons.account_balance_wallet)),
                    Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Obx(
                          () => Text(
                            userController.userData != null
                                ? '₹${userController.userData!.wining + userController.userData!.deposit}'
                                : '',
                            style: appbarTextStyle,
                          ),
                        )),
                  ],
                ),
              ),
            )
          ],
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(25),
              child: Obx(
                () => Container(
                  height: 40,
                  child: Row(
                    children: [
                      contestName("Silver"),
                      contestName('Gold'),
                      contestName('Platinum'),
                      contestName('Diomond'),
                    ],
                  ),
                ),
              )),
        ),
        body: Obx(() => Container(child: bodyWidget())));
  }

  Widget bodyWidget() {
    if (contestNum.value == 'Silver') {
      return MyWidget(userController);
    } else if (contestNum.value == 'Gold') {
      return GoldScreen(
        userController: userController,
      );
    } else if (contestNum.value == 'Platinum') {
      return MyWidget(userController);
    } else {
      return MyWidget(userController);
    }
  }

  Expanded contestName(String text) {
    return Expanded(
        child: InkWell(
      onTap: () {
        contestNum.value = text;
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    color: contestNum.value == text
                        ? btnColor
                        : deepBacgroundColor,
                    width: 2))),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: contestNum.value == text ? btnColor : primaryColor),
          ),
        ),
      ),
    ));
  }
}
