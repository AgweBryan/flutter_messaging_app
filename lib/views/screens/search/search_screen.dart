import 'package:flutter/material.dart';
import 'package:flutter_messaging_app/controllers/search_controller.dart';
import 'package:flutter_messaging_app/models/userModel.dart';
import 'package:flutter_messaging_app/utils/colors.dart';
import 'package:flutter_messaging_app/views/screens/chat/widgets/custom_tile.dart';
import 'package:get/get.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final SearchController _searchController = Get.put(SearchController());
  final TextEditingController _searchTextController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _searchTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      appBar: searchAppBar(context),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Obx(() => buildSuggestions()),
      ),
    );
  }

  buildSuggestions() {
    return ListView.builder(
      itemCount: _searchController.searchedUsers.length,
      itemBuilder: (context, index) {
        CustomUser searchedUser = CustomUser(
          id: _searchController.searchedUsers[index].id,
          photoUrl: _searchController.searchedUsers[index].photoUrl,
          displayName: _searchController.searchedUsers[index].displayName,
          email: _searchController.searchedUsers[index].email,
          username: _searchController.searchedUsers[index].username,
        );
        return CustomTile(
          mini: false,
          onTap: () {},
          leading: CircleAvatar(
            backgroundImage: NetworkImage(
              searchedUser.photoUrl!,
            ),
          ),
          title: Text(
            searchedUser.username!,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            searchedUser.displayName!,
            style: TextStyle(color: greyColor),
          ),
        );
      },
    );
  }

  searchAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: () {
          Get.back();
        },
      ),
      elevation: 0,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(
          kToolbarHeight + 20,
        ),
        child: Padding(
          padding: EdgeInsets.only(
            left: 10,
          ),
          child: TextField(
            cursorColor: blackColor,
            controller: _searchTextController,
            autofocus: true,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 35,
            ),
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.close,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    _searchTextController.text = '';
                  });
                },
              ),
              border: InputBorder.none,
              hintText: "Search",
              hintStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0x88ffffff),
                fontSize: 35,
              ),
            ),
            onChanged: (val) {
              _searchController.searchUser(val);
            },
          ),
        ),
      ),
    );
  }
}
