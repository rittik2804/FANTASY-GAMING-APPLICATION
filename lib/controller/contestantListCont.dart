// contest_participants_controller.dart

import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_number_game/Model/ContestList.dart';

class ContestParticipantsController extends GetxController {
  var participants = <ContestParticipant>[].obs;
  RxInt amount = 20.obs;
  RxInt number = 10.obs;
  var minuteNum = (60 - (DateTime.now().minute)).obs;
  var secondNum = (60 - (DateTime.now().second)).obs;
  var isloading = false.obs;
  var isprevParticipants = false.obs;
  void fetchParticipants(String gameType, String contestId) {
    print(contestId);
    isloading = true.obs;
    FirebaseFirestore.instance
        .collection("Contest")
        .doc(gameType)
        .collection(contestId)
        .get()
        .then((querySnapshot) {
      List<ContestParticipant> fetchedParticipants = [];
      querySnapshot.docs.forEach((doc) {
        fetchedParticipants.add(ContestParticipant(
            name: doc['name'],
            number: doc['Number'],
            amount: doc['Amount'],
            isWin: doc['isWin'],
            mobileNumber: doc['Mobile Number']));
      });
      participants.assignAll(fetchedParticipants);
    }).catchError((error) {
      print("Failed to fetch participants: $error");
    });
    isloading = false.obs;
  }
}
