import 'package:flutter/material.dart';
import 'package:flutter_messaging_app/utils/colors.dart';

class CustomTile extends StatelessWidget {
  final Widget leading;
  final Widget title;
  final Widget subtitle;
  final Widget? icon;
  final Widget? trailing;
  final EdgeInsets? margin;
  final bool? mini;
  final GestureTapCallback? onTap;
  final GestureLongPressCallback? onLongPress;
  const CustomTile(
      {Key? key,
      required this.leading,
      required this.title,
      required this.subtitle,
      this.icon,
      this.trailing,
      this.margin = const EdgeInsets.all(0),
      this.mini = true,
      this.onTap,
      this.onLongPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: mini! ? 10 : 0),
        margin: margin,
        child: Row(
          children: [
            leading,
            Expanded(
              child: Container(
                margin: EdgeInsets.only(
                  left: mini! ? 10 : 15,
                ),
                padding: EdgeInsets.symmetric(vertical: mini! ? 3 : 20),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 1,
                      color: separatorColor,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        title,
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            icon ?? SizedBox(),
                            subtitle,
                          ],
                        )
                      ],
                    ),
                    trailing ?? SizedBox(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
