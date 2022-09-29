import 'package:flutter/material.dart';
import 'package:flutter_messaging_app/utils/colors.dart';
import 'package:flutter_messaging_app/utils/controllers.dart';
import 'package:shimmer/shimmer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      body: Center(
        child: _loginButton(),
      ),
    );
  }

  _loginButton() {
    return GestureDetector(
      onTap: () async {
        setState(() {
          isLoading = true;
        });
        await authController.signInWithGoogle();
      },
      child: Shimmer.fromColors(
        baseColor: Colors.white,
        highlightColor: senderColor,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(10)),
          child: isLoading
              ? CircularProgressIndicator()
              : Text(
                  'LOGIN',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.2,
                  ),
                ),
        ),
      ),
    );
  }
}
