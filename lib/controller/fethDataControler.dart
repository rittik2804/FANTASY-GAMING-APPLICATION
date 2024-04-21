import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_number_game/Model/userDataModel.dart';

class UserController extends GetxController {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('User');
     
  var isUserDataLoading = false.obs;

  Rx<UserData?> user = Rx<UserData?>(null); // Initialize with null

  UserData? get userData => user.value;

  @override
  void onInit() {
    super.onInit();
  }

  void fetchUser(String uid) {
    isUserDataLoading.value = true;
    usersCollection.doc(uid).get().then((DocumentSnapshot doc) {
      if (doc.exists) {
        user.value = UserData(
          uid: doc['Uid'],
          email: doc['Email'],
          mobile: doc['Mobile'],
          name: doc['Name'],
          deposit: doc['Deposit'],
          wining: doc['Wining'],
        );
      } else {
        // Reset user value to null if document doesn't exist
        user.value = null;
        print('User with UID $uid does not exist.');
      }
    }).catchError((error) {
      // Reset user value to null in case of error
      user.value = null;
      print('Error fetching user data: $error');
    });
    isUserDataLoading.value = false;
  }
}
