import 'package:flutter/material.dart';
import 'package:flutter_messaging_app/controllers/conversation_controller.dart';
import 'package:flutter_messaging_app/models/userModel.dart';
import 'package:flutter_messaging_app/utils/colors.dart';
import 'package:flutter_messaging_app/views/widgets/custom_appbar.dart';
import 'package:get/get.dart';

class ConversationScreen extends StatefulWidget {
  final CustomUser user;
  const ConversationScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  final ConversationController _conversationController =
      Get.put(ConversationController());
  final TextEditingController _textFieldController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _textFieldController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      appBar: _customAppBar(context),
      body: Obx(() {
        return Column(
          children: [
            _chatControls(),
          ],
        );
      }),
    );
  }

  _chatControls() {
    return Container(
      padding: EdgeInsets.all(
        10,
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              gradient: fabGradient,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.add,
            ),
          ),
          SizedBox(width: 5),
          Expanded(
            child: TextField(
              controller: _textFieldController,
              style: TextStyle(
                color: Colors.white,
              ),
              onChanged: _conversationController.updateIsTyping,
              decoration: InputDecoration(
                hintText: "Type a message",
                hintStyle: TextStyle(
                  color: greyColor,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 5,
                ),
                filled: true,
                fillColor: separatorColor,
                suffixIcon: GestureDetector(
                  onTap: () {},
                  child: Icon(
                    Icons.face,
                  ),
                ),
              ),
            ),
          ),
          _conversationController.isTyping.value
              ? SizedBox()
              : Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Icon(
                    Icons.record_voice_over,
                  ),
                ),
          _conversationController.isTyping.value
              ? SizedBox()
              : Icon(
                  Icons.camera_alt,
                ),
          _conversationController.isTyping.value
              ? Container(
                  margin: EdgeInsets.only(
                    left: 10,
                  ),
                  decoration: BoxDecoration(
                    gradient: fabGradient,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.send,
                    ),
                    onPressed: () {},
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }

  _customAppBar(BuildContext context) {
    return CustomAppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {},
      ),
      centerTitle: false,
      title: Text(widget.user.displayName!),
      actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.video_call)),
        IconButton(onPressed: () {}, icon: Icon(Icons.phone))
      ],
    );
  }
}
