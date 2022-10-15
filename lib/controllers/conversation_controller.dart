import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_messaging_app/models/message.dart';
import 'package:flutter_messaging_app/utils/controllers.dart';
import 'package:flutter_messaging_app/utils/firebase.dart';
import 'package:get/get.dart';

class ConversationController extends GetxController {
  final String collectionName = 'messages';
  final RxBool isTyping = false.obs;

  final Rx<List<Message>> _messages = Rx<List<Message>>([]);

  String? receiverId;

  List<Message> get messages => _messages.value;

  @override
  void onInit() {
    super.onInit();
    _messages.bindStream(firestore
        .collection(collectionName)
        .doc(authController.currentUser.uid)
        .collection(receiverId!)
        .orderBy("timestamp", descending: true)
        .snapshots()
        .map((QuerySnapshot query) {
      List<Message> retValue = [];
      for (var element in query.docs) {
        retValue.add(Message.fromMap(element as Map<String, dynamic>));
      }
      return retValue;
    }));
  }

  updateReceiverId(String id) {
    receiverId = id;
    print("Receiver id: $receiverId");
  }

  updateIsTyping(String text) {
    isTyping.value = text.isNotEmpty ? true : false;
  }

  addMessageToDb(Message message) async {
    final Map<String, dynamic> map = message.toMap();

    await firestore
        .collection(collectionName)
        .doc(message.senderId)
        .collection(message.receiverId)
        .add(map);

    await firestore
        .collection(collectionName)
        .doc(message.receiverId)
        .collection(message.senderId)
        .add(map);
  }
}
