import 'package:flutter/material.dart';
import 'package:flutter_messaging_app/utils/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final List<Widget> actions;
  final Widget leading;
  final bool centerTitle;
  @override
  final Size preferredSize = Size.fromHeight(kToolbarHeight + 10);
  CustomAppBar(
      {Key? key,
      required this.title,
      required this.actions,
      required this.leading,
      required this.centerTitle})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: blackColor,
          border: Border(
            bottom: BorderSide(
              color: separatorColor,
              width: 1.4,
            ),
          )),
      child: AppBar(
        backgroundColor: blackColor,
        elevation: 0,
        leading: leading,
        actions: actions,
        centerTitle: centerTitle,
        title: title,
      ),
    );
  }
}
