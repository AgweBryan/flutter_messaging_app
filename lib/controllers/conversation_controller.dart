import 'package:flutter_messaging_app/models/message.dart';
import 'package:flutter_messaging_app/utils/firebase.dart';
import 'package:get/get.dart';

class ConversationController extends GetxController {
  final RxBool isTyping = false.obs;

  updateIsTyping(String text) {
    isTyping.value = text.isNotEmpty ? true : false;
  }

  addMessageToDb(Message message) async {
    final Map<String, dynamic> map = message.toMap();

    final String collectionName = 'messages';

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
