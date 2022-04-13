import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:simple/pages/HomeScreen.dart';

class googleServiceProvider {
  String email = '',
      name = '',
      photoUrl = '';

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

  TextEditingController username = TextEditingController();
  TextEditingController regEmail = TextEditingController();
  TextEditingController regPassword = TextEditingController();
  TextEditingController regConfirmPassword = TextEditingController();

  void loginUser(context) async {
    try {
      showDialog(context: context, builder: (context) {
        return Center(child: CircularProgressIndicator(),);
      });
      await auth
          .signInWithEmailAndPassword(
          email: email.text, password: password.text)
          .then((value) =>
      {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (ctx) =>
                HomeScreen(email: 'admin', photoUrl: 'www', name: 'rakib',),
          ),
        ),
      });
    } catch (e) {
      print(e);
    }
  }

  Future registerUser(context) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: regEmail.text, password: regPassword.text).then((value){
            print('User is Registered');
      });
      errorMessage = '';
    } on FirebaseAuthException catch (e){
      errorMessage = e.message!;
     // SnackBar(content: Text('EROOR'),);
      print(e);
    }
  }
  String errorMessage = '';
// final ShowsnackBar = SnackBar(
//   content: Text('${errorMessage}'),
// );
}
