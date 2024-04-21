import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:my_number_game/Screen/accountBalance.dart';
import 'package:my_number_game/Screen/auth/loginScreen.dart';
import 'package:my_number_game/constant/constant.dart';
import 'package:my_number_game/controller/authCont/loginCont.dart';
import 'package:my_number_game/controller/fethDataControler.dart';

Drawer kDrawer() {
  final UserController userController = Get.put(UserController());
  AuthController _authController = AuthController();
  return Drawer(
    backgroundColor: secondaryyColor,
    child: Column(
      children: [
        DrawerHeader(
            child: Container(
          height: double.infinity,
          width: double.infinity,
          child: Padding(
            padding: kPrimaryPadding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const CircleAvatar(
                  radius: 32,
                  child: Icon(
                    Icons.person,
                    size: 50,
                  ),
                ),
                Expanded(
                    child: Container(
                  height: double.infinity,
                  //color: Colors.amber,
                  padding: EdgeInsets.only(left: 7),
                  child: Center(
                    child: Obx(() => userController.userData == null
                        ? const Text(
                            "Personal Details",
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                          )
                        : Text(
                            userController.userData!.name,
                            style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w600,
                                color: primaryColor),
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            maxLines: 1,
                          )),
                  ),
                ))
              ],
            ),
          ),
        )),
        Expanded(
          child: ListView(
            children: [
              drawerList("Profile", Icons.person),
              drawerList(
                "Account",
                Icons.account_balance,
              ),
              drawerList("Result", Icons.copy),
              drawerList("Transaction", Icons.account_tree),
              drawerList("How to  play", Icons.videogame_asset),
            ],
          ),
        ),
        Expanded(
            child: Container(
          padding: kPrimaryPadding,
          width: double.infinity,
          // color: Colors.amber,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text(
                "VERSION 1.1.1",
                style: TextStyle(color: primaryColor),
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _authController.signOut();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: btnColor,
                  ),
                  child: Obx(
                    () => _authController.isLoading.value == true
                        ? const CircularProgressIndicator(
                            color: primaryColor,
                          )
                        : const Text('Log out',
                            style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.bold)),
                  ),
                ),
              )
            ],
          ),
        ))
      ],
    ),
  );
}

Container drawerList(
  String title,
  IconData lIcons,
) {
  return Container(
    decoration: const BoxDecoration(
        // border: Border(bottom: BorderSide())
        // color: secondaryyColor
        ),
    child: ListTile(
      onTap: () {
        if (AuthController.userId != '') {
          Get.to(AccountBalance(uid: AuthController.userId));
        } else {
          Get.to(LoginScreen());
        }
      },
      leading: Icon(
        lIcons,
        color: primaryColor,
      ),
      title: Text(
        title,
        style: const TextStyle(color: primaryColor),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: primaryColor,
      ),
    ),
  );
}
