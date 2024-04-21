import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:my_number_game/Model/ContestList.dart';
import 'package:my_number_game/constant/constant.dart';
import 'package:my_number_game/controller/contestantListCont.dart';

// ignore: camel_case_types
class currentContestList extends StatefulWidget {
  final String gameType;
  final String contestId;

  currentContestList({
    required this.gameType,
    required this.contestId,
  });
  @override
  State<currentContestList> createState() => _currentContestListState();
}

class _currentContestListState extends State<currentContestList> {
  final ContestParticipantsController controller =
      Get.put(ContestParticipantsController());
  @override
  void initState() {
    controller.fetchParticipants(widget.gameType, widget.contestId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 4),
      width: double.infinity,
      // color: deepBacgroundColor,
      child: Obx(
        () {
          if (controller.isloading.value == true) {
            return const Center(
                child: CircularProgressIndicator(
              color: primaryColor,
            ));
          } else {
            return controller.participants.isEmpty
                ? Center(
                    child: Text(
                      'No data found',
                      style: TextStyle(color: primaryColor),
                    ),
                  )
                : ListView.builder(
                    itemCount: controller.participants.length,
                    itemBuilder: (context, index) {
                      final ContestParticipant participant =
                          controller.participants[index];
                      String mobileNumber = participant.mobileNumber.toString();
                      String mobileNumber2 =
                          participant.mobileNumber.toString();
                      return Container(
                        margin:
                            const EdgeInsets.only(top: 4, left: 4, right: 4),
                        decoration: BoxDecoration(
                            border: const Border(
                              //top: BorderSide(color: borderColor),
                              bottom:
                                  BorderSide(color: borderColor, width: 0.2),
                            ),
                            //color: secondaryyColor,
                            borderRadius: BorderRadius.circular(1)),
                        height: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                                flex: 2,
                                child: Container(
                                  // color: Colors.amber,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const CircleAvatar(
                                        backgroundColor: lightBackgroundCollor,
                                        //radius: 32,
                                        child: Icon(
                                          Icons.person, color: primaryColor,
                                          // size: 50,
                                        ),
                                      ),
                                      Text(
                                        '+91${mobileNumber.substring(0, 3)}****${mobileNumber2.substring(mobileNumber.length - 3)}',
                                        style: const TextStyle(
                                            fontSize: 17, color: primaryColor),
                                      ),
                                    ],
                                  ),
                                )),
                            Expanded(
                                child: Container(
                              //color: Colors.blue,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        participant.number.toString(),
                                        style: const TextStyle(
                                            fontSize: 15, color: primaryColor),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        '₹${participant.amount}',
                                        style: const TextStyle(
                                            fontSize: 15, color: primaryColor),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ))
                          ],
                        ),
                      );
                    },
                  );
          }
        },
      ),
    );
  }
}
