import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_messaging_app/models/userModel.dart';
import 'package:flutter_messaging_app/utils/controllers.dart';
import 'package:flutter_messaging_app/utils/firebase.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  final Rx<List<CustomUser>> _searchedUsers = Rx<List<CustomUser>>([]);

  List<CustomUser> get searchedUsers => _searchedUsers.value;

  searchUser(String typedUser) async {
    _searchedUsers.bindStream(firestore
        .collection('users')
        .where('displayName', isGreaterThanOrEqualTo: typedUser)
        .snapshots()
        .map((QuerySnapshot query) {
      List<CustomUser> retVal = [];

      for (final element in query.docs) {
        retVal.add(CustomUser.fromJson(element.data() as Map<String, dynamic>));
      }
      retVal = retVal
          .where(
              (element) => element.email != authController.currentUser.email!)
          .toList();
      return retVal;
    }));
  }
}
