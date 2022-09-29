import 'package:flutter/material.dart';
import 'package:flutter_messaging_app/utils/controllers.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ElevatedButton(
        child: Text('logout'),
        onPressed: () async => authController.signOut(),
      ),
    );
  }
}
