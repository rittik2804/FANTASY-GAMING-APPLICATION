import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:my_number_game/Screen/LeaderBoard/current.dart';
import 'package:my_number_game/Screen/LeaderBoard/RecentResult.dart';
import 'package:my_number_game/Screen/homeScreen.dart';
import 'package:my_number_game/Screen/widget/contestID.dart';
import '../constant/constant.dart';

class ContestList extends StatefulWidget {
  final String gameType;
  final String contestId;

  ContestList({
    required this.gameType,
    required this.contestId,
  });

  @override
  State<ContestList> createState() => _ContestListState();
}

class _ContestListState extends State<ContestList> {
  var array = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  RxString currentPage = '1'.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: deepBacgroundColor,
        title: const Text(
          "LeaderBoard",
          style: textStyle,
        ),
        leading: IconButton(
          onPressed: () {
            Get.to(HomeScreen());
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: primaryColor,
          ),
        ),
      ),
      body: Container(
        color: deepBacgroundColor,
        height: MediaQuery.of(context).size.height - kToolbarHeight,
        child: Column(
          children: [
            Obx(
              () => Container(
                //margin: kPrimaryPadding,
                height: 30,
                color: secondaryyColor,
                child: Row(
                  children: [
                    Expanded(
                        child: InkWell(
                      onTap: () {
                        currentPage.value = '1';
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: currentPage.value == '1'
                                ? btnColor
                                : secondaryyColor,
                            border: currentPage.value == '1'
                                ? const Border(
                                    right: BorderSide(
                                      color: borderColor,
                                    ),
                                    bottom: BorderSide(color: borderColor))
                                : null),
                        child: const Center(
                          child: Text(
                            'Current',
                            style: appbarTextStyle,
                          ),
                        ),
                      ),
                    )),
                    Expanded(
                        child: InkWell(
                      onTap: () {
                        print('clicked');
                        currentPage.value = '2';
                        // Get.to(RecentResult(
                        //     gameType: widget.gameType,
                        //     contestId: widget.contestId));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: currentPage.value == '2'
                                ? btnColor
                                : secondaryyColor,
                            border: currentPage.value == '2'
                                ? const Border(
                                    left: BorderSide(color: borderColor),
                                    bottom: BorderSide(color: borderColor))
                                : null),
                        child: const Center(
                          child: Text(
                            'Recent',
                            style: appbarTextStyle,
                          ),
                        ),
                      ),
                    ))
                  ],
                ),
              ),
            ),
            Expanded(
              child: Obx(() => currentPage.value == '1'
                  ? currentContestList(
                      gameType: widget.gameType,
                      contestId: widget.contestId,
                    )
                  : RecentResult(
                      gameType: widget.gameType, contestId: widget.contestId)),
            ),
          ],
        ),
      ),
    );
  }
}
