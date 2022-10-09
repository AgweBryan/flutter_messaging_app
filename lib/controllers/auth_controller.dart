import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_messaging_app/models/userModel.dart';
import 'package:flutter_messaging_app/utils/firebase.dart';
import 'package:flutter_messaging_app/utils/utils.dart';
import 'package:flutter_messaging_app/views/screens/authentication/login_screen.dart';
import 'package:flutter_messaging_app/views/screens/home/home_screen.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  static final AuthController instance = Get.find();

  late Rx<User?> _user;
  User get currentUser => _user.value!;

  @override
  void onReady() async {
    super.onReady();
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
    ever(_user, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => LoginScreen());
    } else {
      Get.offAll(() => HomeScreen());
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await firebaseAuth.signInWithCredential(credential);
  }

  signOut() async {
    await firebaseAuth.signOut();
    Get.offAll(LoginScreen());
  }

// add signed in user to firebase firestore
  addCurrentUserToFirestore() async {
    CustomUser cu = CustomUser(
      id: currentUser.uid,
      displayName: currentUser.displayName,
      email: currentUser.email,
      username: Util.getUsername(currentUser.email!),
      photoUrl: currentUser.photoURL,
    );
    await firestore.collection('users').doc(currentUser.uid).set(cu.toMap());
  }

  // Get all users
  Future<List<CustomUser>> getAllUsers() async {
    List<CustomUser> usersList = [];

    QuerySnapshot querySnapshot = await firestore.collection('users').get();

    for (var i = 0; i < querySnapshot.docs.length; i++) {
      if (querySnapshot.docs[i].id != currentUser.uid) {
        usersList.add(CustomUser.fromJson(
            querySnapshot.docs[i].data() as Map<String, dynamic>));
      }
    }

    print(querySnapshot.docs);
    return usersList;
  }
}
