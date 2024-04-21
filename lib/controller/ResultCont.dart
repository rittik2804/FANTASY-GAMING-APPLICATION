import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ContestResult {
  final String contestId;
  final dynamic result;

  ContestResult(this.contestId, this.result);
}

class ResultController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxList<ContestResult> resultList = RxList<ContestResult>();
  var resultLoading = true.obs;

  Future<void> fetchData(String gameType, String game_number) async {
    resultLoading = true.obs;
    try {
      var collection = FirebaseFirestore.instance
          .collection('Contest')
          .doc('Gold')
          .collection("Result");

      var querySnapshot = await collection.get();
      if (querySnapshot.docs.isNotEmpty) {
        resultList.clear();
        // Clear the list before adding new data
        for (var queryDocumentSnapshot in querySnapshot.docs) {
          // Check if document ID contains "2024"
          if (queryDocumentSnapshot.id
              .startsWith(contestIdForResult(game_number))) {
            Map<String, dynamic> data = queryDocumentSnapshot.data();
            var result = data['Result'];
            var contestId = queryDocumentSnapshot.id;
            var lastDigit = contestId.substring(contestId.length - 2);
            resultList.add(ContestResult(lastDigit, result));
          }
        }
        resultList = resultList.reversed.toList().obs;
      }
      Future.delayed(Duration(milliseconds: 300), () {
        resultLoading.value = false;
      });
      print(resultList);
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  String contestIdForResult(String game_number) {
    int currentHour = DateTime.now().hour;
    if (currentHour < 8) {
      return '${DateTime.now().year}${DateTime.now().month}${DateTime.now().day - 1}${game_number}';
    } else {
      return '${DateTime.now().year}${DateTime.now().month}${DateTime.now().day}${game_number}';
    }
  }
}
