import 'package:flutter/material.dart';
import 'package:flutter_messaging_app/utils/colors.dart';

class NewChatbutton extends StatelessWidget {
  const NewChatbutton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(
        gradient: fabGradient,
        borderRadius: BorderRadius.circular(
          50,
        ),
      ),
      child: Icon(
        Icons.edit,
        color: Colors.white,
        size: 25,
      ),
    );
  }
}
