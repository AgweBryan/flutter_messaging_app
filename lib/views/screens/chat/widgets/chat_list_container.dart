import 'package:flutter/material.dart';
import 'package:flutter_messaging_app/utils/colors.dart';
import 'package:flutter_messaging_app/views/screens/chat/widgets/custom_tile.dart';

class ChatListContainer extends StatelessWidget {
  final String currentUserId;
  const ChatListContainer({Key? key, required this.currentUserId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: ListView.builder(
      padding: EdgeInsets.all(10),
      itemCount: 2,
      itemBuilder: (context, index) {
        return CustomTile(
          mini: false,
          onTap: () {},
          title: Text(
            "Agwemedia",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Arial',
              fontSize: 19,
            ),
          ),
          subtitle: Text(
            "Hello",
            style: TextStyle(
              color: greyColor,
              fontSize: 14,
            ),
          ),
          leading: Container(
            constraints: BoxConstraints(
              maxHeight: 60,
              maxWidth: 60,
            ),
            child: Stack(
              children: [
                CircleAvatar(
                  maxRadius: 30,
                  backgroundColor: Colors.grey,
                  backgroundImage: NetworkImage(
                      "https://firebasestorage.googleapis.com/v0/b/images-8f729.appspot.com/o/my_logo.jpeg?alt=media&token=0a415b9a-4da1-41a2-b4de-71942bdf89c8"),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    height: 13,
                    width: 13,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: onlineDotColor,
                        border: Border.all(
                          color: blackColor,
                          width: 2,
                        )),
                  ),
                )
              ],
            ),
          ),
        );
      },
    ));
  }
}
