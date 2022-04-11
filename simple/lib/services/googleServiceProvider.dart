import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:simple/pages/HomeScreen.dart';

class googleServiceProvider {
  String email = '', name = '', photoUrl = '';

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    email = googleUser!.email;
    name = googleUser.displayName!;
    photoUrl = googleUser.photoUrl!;
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future logout() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().disconnect();
    FirebaseAuth.instance.signOut();
  }
}

class RegisterLoginAuth {
  final auth = FirebaseAuth.instance;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  void loginUser(context) async {
    try {
      CircularProgressIndicator();
      await auth
          .signInWithEmailAndPassword(
              email: email.text, password: password.text)
          .then((value) => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => HomeScreen(),
                  ),
                ),
              });
    } catch (e) {
      print(e);
    }
  }
}
