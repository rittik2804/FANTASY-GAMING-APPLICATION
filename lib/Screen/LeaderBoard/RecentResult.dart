import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:my_number_game/Model/ContestList.dart';
import 'package:my_number_game/Screen/widget/contestID.dart';
import 'package:my_number_game/constant/constant.dart';
import 'package:my_number_game/controller/contestantListCont.dart';
import 'package:my_number_game/controller/prevContestList.dart';

class RecentResult extends StatefulWidget {
  final String gameType;
  final String contestId;

  RecentResult({
    required this.gameType,
    required this.contestId,
  });

  @override
  State<RecentResult> createState() => _RecentResultState();
}

class _RecentResultState extends State<RecentResult> {
  final ContestParticipantsController _controller =
      Get.put(ContestParticipantsController());
  @override
  void initState() {
    _controller.fetchParticipants(widget.gameType, prevContestId());
    super.initState();
  }

  String prevContestId() {
    String cont = contestId(contestTypeNumber(widget.gameType));
    int prevCont = int.parse(cont) - 1;
    return prevCont.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 4),
      width: double.infinity,
      // color: deepBacgroundColor,
      child: Obx(
        () {
          if (_controller.participants.isEmpty) {
            return const Center(
                child: CircularProgressIndicator(
              color: primaryColor,
            ));
          } else {
            return ListView.builder(
              itemCount: _controller.participants.length,
              itemBuilder: (context, index) {
                final ContestParticipant participant =
                    _controller.participants[index];
                String mobileNumber = participant.mobileNumber.toString();
                String mobileNumber2 = participant.mobileNumber.toString();
                return Container(
                  margin: const EdgeInsets.only(top: 4, left: 4, right: 4),
                  decoration: BoxDecoration(
                      border: const Border(
                        //top: BorderSide(color: borderColor),
                        bottom: BorderSide(color: borderColor, width: 0.2),
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: Container(
                                    //  height: double.infinity,
                                    // color: Colors.blue,
                                    child: CircleAvatar(
                                      backgroundColor: lightBackgroundCollor,
                                      //radius: 32,
                                      child: Icon(
                                        Icons.person, color: primaryColor,
                                        // size: 50,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                      height: double.infinity,
                                      //  color: Colors.amber,
                                      child: participant.isWin == true
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '+91${mobileNumber.substring(0, 3)}****${mobileNumber2.substring(mobileNumber.length - 3)}',
                                                  style: const TextStyle(
                                                      fontSize: 17,
                                                      color: primaryColor),
                                                ),
                                                Text(
                                                  'Won ₹${participant.amount * int.parse(contestTypeNumber(widget.gameType))}',
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.green),
                                                ),
                                              ],
                                            )
                                          : Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '+91${mobileNumber.substring(0, 3)}****${mobileNumber2.substring(mobileNumber.length - 3)}',
                                                  style: const TextStyle(
                                                      fontSize: 17,
                                                      color: primaryColor),
                                                ),
                                              ],
                                            )),
                                ),
                              ],
                            ),
                          )),
                      Expanded(
                          child: Container(
                        //color: Colors.blue,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
