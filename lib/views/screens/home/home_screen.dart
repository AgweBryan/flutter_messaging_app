import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_messaging_app/utils/colors.dart';
import 'package:flutter_messaging_app/utils/controllers.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _pageController;
  int _pageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  void onPageChanged(int pageIndex) {
    setState(() {
      _pageIndex = pageIndex;
    });
  }

  void navigationTapped(int pageIndex) {
    _pageController.jumpToPage(pageIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: blackColor,
        bottomNavigationBar: SizedBox(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 10,
            ),
            child: CupertinoTabBar(
              onTap: navigationTapped,
              currentIndex: _pageIndex,
              backgroundColor: blackColor,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.chat,
                      color: _pageIndex == 0 ? lightBlueColor : greyColor,
                    ),
                    label: "Chats"),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.chat,
                      color: _pageIndex == 1 ? lightBlueColor : greyColor,
                    ),
                    label: "Call"),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.contacts,
                      color: _pageIndex == 2 ? lightBlueColor : greyColor,
                    ),
                    label: "Contacts"),
              ],
            ),
          ),
        ),
        body: PageView(
          controller: _pageController,
          onPageChanged: onPageChanged,
          children: [
            Center(
              child: Text("Chat list Screen"),
            ),
            Center(
              child: Text("call logs"),
            ),
            Center(
              child: Text("contact screen"),
            ),
          ],
        ));
  }
}
