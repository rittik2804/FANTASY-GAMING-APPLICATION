import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:my_number_game/Model/ContestList.dart';

class PrevContestList extends GetxController {
  var prevParticipants = <ContestParticipant>[].obs;

  Future<void> fetchPrevParticipentList(
      String gameType, String contestId) async {
    print(contestId);
    // isprevParticipants.value = true;
    FirebaseFirestore.instance
        .collection("Contest")
        .doc(gameType)
        .collection(contestId)
        .get()
        .then((querySnapshot) {
          List<ContestParticipant> fetchedPrevParticipants = [];
          querySnapshot.docs.forEach((doc) {
            fetchedPrevParticipants.add(ContestParticipant(
                name: doc['name'],
                number: doc['Number'],
                amount: doc['Amount'],
                isWin: doc['isWin'],
                mobileNumber: doc['Mobile Number']));
          });
          prevParticipants.assignAll(fetchedPrevParticipants);
        })
        .then((value) => print(prevParticipants))
        .catchError((error) {
          print("Failed to fetch participants2: $error");
        });
    // isprevParticipants.value = false;
  }
}
