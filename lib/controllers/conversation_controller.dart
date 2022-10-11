import 'package:get/get.dart';

class ConversationController extends GetxController {
  final RxBool isTyping = false.obs;

  updateIsTyping(String text) {
    isTyping.value = text.isNotEmpty ? true : false;
  }
}
