import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:get/get.dart';
import 'package:my_number_game/Screen/auth/loginScreen.dart';
import 'package:my_number_game/Screen/contestList.dart';
import 'package:my_number_game/Screen/widget/contestID.dart';
import 'package:my_number_game/common/commonTost.dart';
import 'package:my_number_game/controller/ResultCont.dart';
import 'package:my_number_game/controller/authCont/loginCont.dart';
import 'package:my_number_game/controller/contestantListCont.dart';
import 'package:my_number_game/controller/fethDataControler.dart';
import 'package:my_number_game/controller/joinContest.dart';
import '../../constant/constant.dart';

class MyWidget extends StatefulWidget {
  UserController _userController;
  MyWidget(this._userController);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final ContestParticipantsController controller =
      Get.put(ContestParticipantsController());
  final joinContest _joinContestController = Get.put(joinContest());
  StreamController<int> selected = StreamController<int>();
  final ResultController resultController = Get.put(ResultController());

  int minuteNum = 70;
  int secondNum = 70;
  Timer? _timer;
  int maxAmount = 1000;
  int minAmount = 20;

  void updatTime() {
    controller.minuteNum.value = 60 - (DateTime.now().minute);
    controller.secondNum.value = 60 - (DateTime.now().second);

    _joinContestController.contestid.value = contestId(4.toString());
  }

  @override
  void initState() {
    _timer =
        Timer.periodic(const Duration(seconds: 1), (Timer t) => updatTime());
    controller.number = 10.obs;
    controller.amount = 20.obs;
    _joinContestController.contestid = contestId(4.toString()).obs;
    resultController.fetchData('Silver', '4');
    debugPrint("the contest id is${_joinContestController.contestid.value}");
    debugPrint("App started....");

    super.initState();
  }

  @override
  void dispose() {
    _timer!.cancel();
    selected.close();
    super.dispose();
  }

  final items = <int>[
    0,
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
  ];

  @override
  Widget build(BuildContext context) {
    recreateSelectedStream();
    final height = MediaQuery.of(context).size.height -
        kBottomNavigationBarHeight -
        kToolbarHeight;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        height: height,
        width: double.infinity,
        padding: kPrimaryPadding,
        color: deepBacgroundColor,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 1),
              height: height * 0.05,
              width: double.infinity,
              //color: Colors.amber,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FittedBox(
                      fit: BoxFit.contain,
                      child: Obx(() => Text(
                            "Round #${_joinContestController.contestid.value}",
                            style: textStyle,
                          ))),
                  Obx(() => Text(
                        "${controller.minuteNum.value}m${controller.secondNum.value}s",
                        style: const TextStyle(color: primaryColor),
                      ))
                ],
              ),
            ),
            Container(
                // color: Colors.amber,
                height: height * 0.21,
                width: double.infinity,
                child: Stack(children: [
                  Positioned(
                      bottom: 0,
                      left: 0,
                      child: Obx(() => Container(
                            // color: Colors.amber,
                            child: Row(
                              children: [
                                Text(
                                  "You will get ",
                                  style: const TextStyle(
                                      fontSize: 11,
                                      color: Colors.white,
                                      height: 1),
                                ),
                                Text(
                                  " ₹${controller.amount.value * 9}",
                                  style: const TextStyle(
                                      fontSize: 13, color: btnColor, height: 1),
                                ),
                              ],
                            ),
                          ))),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: InkWell(
                        onTap: () {
                          Get.to(ContestList(
                              gameType: 'Silver',
                              contestId:
                                  _joinContestController.contestid.value));
                        },
                        child: const Icon(
                          Icons.edit_square,
                          color: primaryColor,
                        ),
                      )),
                  FortuneWheel(
                      physics: CircularPanPhysics(
                        duration: const Duration(seconds: 160),
                        curve: Curves.decelerate,
                      ),
                      onFling: () {
                        debugPrint('onFling');
                        selected.add(1);
                      },
                      onAnimationStart: () {
                        debugPrint('animation start');
                      },
                      onAnimationEnd: () {
                        debugPrint('animation end ${selected.stream}');
                      },
                      animateFirst: true,
                      selected: selected.stream,
                      items: [
                        for (var it in items)
                          FortuneItem(
                              child: Text(
                                it.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              style: const FortuneItemStyle(
                                  color: secondaryyColor,
                                  borderColor: borderColor,
                                  textAlign: TextAlign.end)),
                      ]),
                ])),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              height: height * 0.2,
              width: double.infinity,
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 20,
                    child: Row(
                      children: [
                        Expanded(
                            child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Column(
                            children: [
                              Expanded(child: Container()),
                              Expanded(
                                  child: Container(
                                decoration: const BoxDecoration(
                                    border: Border(
                                        top: BorderSide(
                                            width: 1, color: borderColor))),
                              ))
                            ],
                          ),
                        )),
                        const Text(
                          "Pick a Number",
                          style: TextStyle(color: primaryColor),
                        ),
                        Expanded(
                            child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Column(
                            children: [
                              Expanded(child: Container()),
                              Expanded(
                                  child: Container(
                                decoration: const BoxDecoration(
                                    border: Border(
                                        top: BorderSide(
                                            width: 1, color: borderColor))),
                              ))
                            ],
                          ),
                        )),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Expanded(
                      child: Obx(() => Container(
                            child: Column(
                              children: [
                                Expanded(
                                    child: Row(
                                  children: [
                                    numButton("0"),
                                    numButton("1"),
                                    numButton("2"),
                                    numButton("3"),
                                    numButton("4"),
                                  ],
                                )),
                                Expanded(
                                    child: Row(
                                  children: [
                                    numButton("5"),
                                    numButton("6"),
                                    numButton("7"),
                                    numButton("8"),
                                    numButton("9"),
                                  ],
                                )),
                              ],
                            ),
                          )))
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              height: height * 0.21,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 20,
                    child: Row(
                      children: [
                        Expanded(
                            child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Column(
                            children: [
                              Expanded(child: Container()),
                              Expanded(
                                  child: Container(
                                decoration: const BoxDecoration(
                                    border: Border(
                                        top: BorderSide(
                                            width: 1, color: borderColor))),
                              ))
                            ],
                          ),
                        )),
                        const Text(
                          "Enter Amount",
                          style: TextStyle(color: primaryColor),
                        ),
                        Expanded(
                            child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Column(
                            children: [
                              Expanded(child: Container()),
                              Expanded(
                                  child: Container(
                                decoration: const BoxDecoration(
                                    border: Border(
                                        top: BorderSide(
                                            width: 1, color: borderColor))),
                              ))
                            ],
                          ),
                        )),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                            child: Row(
                          children: [
                            Expanded(
                                flex: 6,
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        margin: const EdgeInsets.fromLTRB(
                                            5, 2, 5, 5),
                                        height: double.infinity,
                                        decoration: const BoxDecoration(
                                            color: secondaryyColor,
                                            border:
                                                Border(bottom: BorderSide())),
                                        child: Center(
                                            child: Obx(() => Text(
                                                  '₹${controller.amount.value}',
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: primaryColor),
                                                ))),
                                      ),
                                    ),
                                  ],
                                )),
                            Expanded(
                                flex: 7,
                                child: Container(
                                  child: Row(
                                    children: [
                                      amountButton(
                                        "Plus",
                                        controller,
                                      ),
                                      amountButton("Minus", controller)
                                    ],
                                  ),
                                ))
                          ],
                        )),
                        Expanded(
                            child: Container(
                          child: Row(
                            children: [
                              amountButton("Min", controller),
                              amountButton("+10", controller),
                              amountButton("+25", controller),
                              amountButton("+50", controller),
                              amountButton("Max", controller)
                            ],
                          ),
                        )),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 20,
                      child: Row(
                        children: [
                          Expanded(
                              child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Column(
                              children: [
                                Expanded(child: Container()),
                                Expanded(
                                    child: Container(
                                  decoration: const BoxDecoration(
                                      border: Border(
                                          top: BorderSide(
                                              width: 1, color: borderColor))),
                                ))
                              ],
                            ),
                          )),
                          const Text(
                            "Recent Result",
                            style: TextStyle(color: primaryColor),
                          ),
                          Expanded(
                              child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Column(
                              children: [
                                Expanded(child: Container()),
                                Expanded(
                                    child: Container(
                                  decoration: const BoxDecoration(
                                      border: Border(
                                          top: BorderSide(
                                              width: 1, color: borderColor))),
                                ))
                              ],
                            ),
                          )),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Expanded(
                      child: Obx(() {
                        if (resultController.resultLoading.value == true) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else {
                          return resultController.resultList.isEmpty
                              ? const Center(
                                  child: Text(
                                    'No Result for Today',
                                    style: appbarTextStyle,
                                  ),
                                )
                              : ListView.builder(
                                  // reverse: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: resultController.resultList.length,
                                  itemBuilder: (context, index) {
                                    var result =
                                        resultController.resultList[index];
                                    return resuntNumber(
                                        result.result.toString(),
                                        result.contestId.toString());
                                  },
                                );
                        }
                      }),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: deepBacgroundColor,
        elevation: 0,
        child: ElevatedButton(
          onPressed: () {
            if (AuthController.uidLoading.value == false) {
              if (controller.number.value != 10) {
                if (AuthController.userId != '') {
                  if (controller.amount.value <=
                      widget._userController.userData!.deposit +
                          widget._userController.userData!.wining) {
                    kbottomSheet(context);
                  } else {
                    CommonToast(
                        context: context,
                        title: 'Not Enough Balance',
                        alignCenter: false);
                  }
                } else {
                  Get.to(LoginScreen());
                }
              } else {
                CommonToast(
                    context: context,
                    title: "Please Select a number",
                    alignCenter: false);
              }
            }
          },
          style: ElevatedButton.styleFrom(backgroundColor: btnColor),
          child: Obx(
            () => AuthController.uidLoading.value == true
                ? const CircularProgressIndicator()
                : const Text(
                    "Bet Now",
                    style: btnTextStyle,
                  ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> kbottomSheet(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (builder) {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                height: MediaQuery.of(context).size.height * 0.2,
                width: double.infinity,
                color: deepBacgroundColor,
                child: Container(
                  decoration: const BoxDecoration(
                      color: deepBacgroundColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        // color: Colors.amber,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              controller.number.value.toString(),
                              style: const TextStyle(
                                  fontSize: 30, color: primaryColor),
                            ),
                            const Text(
                              "You bet for",
                              style:
                                  TextStyle(fontSize: 20, color: primaryColor),
                            ),
                            Text(
                              "₹${controller.amount.value}",
                              style: const TextStyle(
                                  fontSize: 30, color: primaryColor),
                            )
                          ],
                        ),
                      ),
                      // Container(
                      //  // color: Colors.blue,
                      //   height: 35,
                      //   child: TextFormField(
                      //     decoration: InputDecoration(
                      //       label: Text("Add Note"),
                      //       enabledBorder: InputBorder.none
                      //     ),
                      //   ),
                      // ),

                      Container(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            _joinContestController.jointcontest(
                                "Silver",
                                _joinContestController.contestid.value,
                                controller.number.toInt(),
                                controller.amount.toInt(),
                                widget._userController.userData!.wining,
                                widget._userController.userData!.deposit,
                                context,
                                AuthController.mobileNumber,
                                AuthController.userId);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: secondaryyColor),
                          child: Obx(
                            () => _joinContestController.isloading.value == true
                                ? const CircularProgressIndicator(
                                    color: primaryColor,
                                  )
                                : const Text(
                                    "Confirm",
                                    style: TextStyle(
                                        color: primaryColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20),
                                  ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget resuntNumber(String resuntNum, String time) {
    String ctime = time;
    if (int.parse(time) > 12) {
      int dtime = int.parse(time) - 12;
      ctime = '$dtime:00 pm';
    } else {
      ctime = '$time:00 am';
    }
    return Container(
      margin: const EdgeInsets.only(left: 5),
      height: double.infinity,
      width: 100,
      decoration: BoxDecoration(
        // border: Border.all(),
        color: secondaryyColor,

        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 7,
          ),
          FittedBox(
            fit: BoxFit.cover,
            child: Text(
              ctime,
              style: const TextStyle(color: primaryColor),
            ),
          ),
          Expanded(
              child: Container(
                  height: double.infinity,
                  child: Center(
                      child: FittedBox(
                    fit: BoxFit.cover,
                    child: Text(
                      resuntNum.toString(),
                      style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: primaryColor),
                    ),
                  )))),
          FittedBox(
            fit: BoxFit.cover,
            child: Text(
              '${resultController.contestIdForResult('4').substring(5, 7)}.${resultController.contestIdForResult('4').substring(4, 5)}.${resultController.contestIdForResult('4').substring(0, 4)}',
              style: const TextStyle(color: primaryColor, fontSize: 10),
            ),
          ),
          SizedBox(
            height: 5,
          )
        ],
      ),
    );
  }

  Expanded numButton(String numText) {
    return Expanded(
        child: InkWell(
      onTap: () {
        controller.number.value = int.parse(numText);
        print(controller.number);
      },
      child: Container(
        margin: const EdgeInsets.all(4),
        height: double.infinity,
        decoration: BoxDecoration(
            color: secondaryyColor,
            //  border: Border.all(),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
                color: controller.number.value == int.parse(numText)
                    ? btnColor
                    : secondaryyColor)),
        child: Center(
            child: Text(
          numText.toString(),
          style:
              const TextStyle(color: primaryColor, fontWeight: FontWeight.w500),
        )),
      ),
    ));
  }

  Expanded amountButton(
      String numText, ContestParticipantsController controller) {
    return Expanded(
        child: InkWell(
      onTap: () {
        if (numText == "Plus" && controller.amount.value < 1000) {
          controller.amount.value++;
        } else if (numText == "Minus" && controller.amount.value > 20) {
          controller.amount.value--;
        } else if (numText == "Min") {
          controller.amount.value = 20;
        } else if (numText == "+10" &&
            controller.amount.value < maxAmount - 10) {
          controller.amount.value = controller.amount.value + 10;
        } else if (numText == "+25" &&
            controller.amount.value < maxAmount - 25) {
          controller.amount.value = controller.amount.value + 25;
        } else if (numText == "+50" &&
            controller.amount.value < maxAmount - 50) {
          controller.amount.value = controller.amount.value + 50;
        } else if (numText == "Max") {
          controller.amount.value = 1000;
        }
      },
      child: Container(
        margin: const EdgeInsets.all(4),
        height: double.infinity,
        decoration: BoxDecoration(
            color: secondaryyColor, borderRadius: BorderRadius.circular(8)),
        child: Center(
            child: Text(
          numText.toString(),
          style: const TextStyle(color: primaryColor),
        )),
      ),
    ));
  }

  void recreateSelectedStream() {
    selected?.close(); // Close existing stream controller if it exists
    selected = StreamController<int>(); // Recreate the stream controller
  }
}
