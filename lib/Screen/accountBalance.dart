import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_number_game/constant/constant.dart';
import 'package:my_number_game/controller/fethDataControler.dart';

// ignore: must_be_immutable
class AccountBalance extends StatefulWidget {
  String uid;
  AccountBalance({super.key, required this.uid});

  @override
  State<AccountBalance> createState() => _AccountBalanceState();
}

class _AccountBalanceState extends State<AccountBalance> {
  final UserController userController = Get.put(UserController());

  @override
  void initState() {
    userController.fetchUser(widget.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('object');
    return Scaffold(
      backgroundColor: deepBacgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: deepBacgroundColor,
        title: const Text(
          "Account Balance",
          style: appbarTextStyle,
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: primaryColor,
            )),
      ),
      body: Container(
          padding: kPrimaryPadding,
          margin: const EdgeInsets.only(top: 15),
          color: deepBacgroundColor,
          child: userController.userData == null
              ? const Center(
                  child: CircularProgressIndicator(
                  color: primaryColor,
                ))
              : Container(
                  height: 300,
                  width: double.infinity,
                  decoration: const BoxDecoration(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Total Balance",
                        style: TextStyle(color: primaryColor, fontSize: 18),
                      ),
                      Text(
                        '₹${userController.userData!.deposit + userController.userData!.wining}',
                        style:
                            const TextStyle(color: primaryColor, fontSize: 17),
                      ),
                      const Text(
                        "Wining Balance",
                        style: TextStyle(color: primaryColor, fontSize: 18),
                      ),
                      Text(
                        '₹${userController.userData!.wining}',
                        style:
                            const TextStyle(color: primaryColor, fontSize: 17),
                      ),
                      const Text(
                        "Deposit Balance",
                        style: TextStyle(color: primaryColor, fontSize: 18),
                      ),
                      Text(
                        '₹${userController.userData!.deposit}',
                        style:
                            const TextStyle(color: primaryColor, fontSize: 17),
                      ),
                    ],
                  ),
                )),
    );
  }
}
