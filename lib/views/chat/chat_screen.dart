import 'package:flutter/material.dart';
import 'package:flutter_messaging_app/utils/colors.dart';
import 'package:flutter_messaging_app/utils/controllers.dart';
import 'package:flutter_messaging_app/utils/utils.dart';
import 'package:flutter_messaging_app/views/widgets/custom_appbar.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  final String cuid = authController.currentUser.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      appBar: _customAppBar(context),
    );
  }

  CustomAppBar _customAppBar(BuildContext context) {
    return CustomAppBar(
      leading: IconButton(
        icon: Icon(
          Icons.notifications,
          color: Colors.white,
        ),
        onPressed: () {},
      ),
      title: _userCircle(
        Util.getInitials(authController.currentUser.displayName!),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.search,
            color: Colors.white,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.more_vert,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  _userCircle(String text) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        color: separatorColor,
        borderRadius: BorderRadius.circular(
          50,
        ),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: lightBlueColor,
                fontSize: 13,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              height: 12,
              width: 12,
              decoration: BoxDecoration(
                color: onlineDotColor,
                shape: BoxShape.circle,
                border: Border.all(
                  color: blackColor,
                  width: 2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
