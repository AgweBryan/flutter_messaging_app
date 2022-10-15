import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_messaging_app/controllers/conversation_controller.dart';
import 'package:flutter_messaging_app/models/message.dart';
import 'package:flutter_messaging_app/models/userModel.dart';
import 'package:flutter_messaging_app/utils/colors.dart';
import 'package:flutter_messaging_app/utils/controllers.dart';
import 'package:flutter_messaging_app/views/screens/conversation/modal_tile.dart';
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
    _conversationController.updateReceiverId(widget.user.id!);
    return Scaffold(
      backgroundColor: blackColor,
      appBar: _customAppBar(context),
      body: Obx(() {
        return Column(
          children: [
            Flexible(
              child: _conversationController.messages.isEmpty
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : _messageList(),
            ),
            _chatControls(),
          ],
        );
      }),
    );
  }

  _messageList() {
    return ListView.builder(
      itemCount: _conversationController.messages.length,
      padding: EdgeInsets.all(10),
      itemBuilder: (context, i) {
        return _chatMessageitem(_conversationController.messages[i]);
      },
    );
  }

  _chatMessageitem(Message message) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 15,
      ),
      child: Container(
        child: message.senderId == authController.currentUser.uid
            ? _senderLayout(message)
            : _receiverLayout(message),
      ),
    );
  }

  _senderLayout(Message message) {
    Radius messageRadius = Radius.circular(
      10,
    );

    return Row(
      children: [
        Expanded(
          child: SizedBox(),
        ),
        Container(
          margin: EdgeInsets.only(
            top: 12,
          ),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * .65,
          ),
          decoration: BoxDecoration(
            color: senderColor,
            borderRadius: BorderRadius.only(
              topLeft: messageRadius,
              topRight: messageRadius,
              bottomLeft: messageRadius,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(
              10,
            ),
            child: getMessage(message),
          ),
        ),
      ],
    );
  }

  getMessage(Message message) {
    return Text(
      message.message,
      style: TextStyle(
        fontSize: 16,
        color: Colors.white,
      ),
    );
  }

  _receiverLayout(Message message) {
    Radius messageRadius = Radius.circular(
      10,
    );

    return Row(
      children: [
        Expanded(
          child: SizedBox(),
        ),
        Container(
          margin: EdgeInsets.only(
            top: 12,
          ),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * .65,
          ),
          decoration: BoxDecoration(
            color: receiverColor,
            borderRadius: BorderRadius.only(
              bottomRight: messageRadius,
              topRight: messageRadius,
              bottomLeft: messageRadius,
            ),
          ),
          child: Padding(
              padding: EdgeInsets.all(
                10,
              ),
              child: getMessage(message)),
        ),
      ],
    );
  }

  _chatControls() {
    return Container(
      padding: EdgeInsets.all(
        10,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => addMediaModal(context),
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                gradient: fabGradient,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.add,
              ),
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
                      size: 15,
                    ),
                    onPressed: () => sendMessage(),
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }

  sendMessage() {
    Message message = Message(
        receiverId: widget.user.id!,
        senderId: authController.currentUser.uid,
        message: _textFieldController.text,
        timestamp: FieldValue.serverTimestamp(),
        type: "text");

    _conversationController.updateIsTyping('');
    _textFieldController.text = '';
  }

  addMediaModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      elevation: 0,
      backgroundColor: blackColor,
      builder: (context) => Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 15,
            ),
            child: Row(
              children: [
                TextButton(
                  onPressed: () => Get.back(),
                  child: Icon(
                    Icons.close,
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Content and tools",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            child: ListView(
              children: [
                ModalTile(
                  title: "Media",
                  subtitle: "Share photos and video",
                  icon: Icons.image,
                ),
                ModalTile(
                  title: "File",
                  subtitle: "Share files",
                  icon: Icons.tab,
                ),
                ModalTile(
                  title: "Contact",
                  subtitle: "Share contacts",
                  icon: Icons.contacts,
                ),
                ModalTile(
                  title: "Location",
                  subtitle: "Share a location",
                  icon: Icons.add_location,
                ),
              ],
            ),
          ),
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
