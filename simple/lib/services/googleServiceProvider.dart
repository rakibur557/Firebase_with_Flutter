import 'dart:html';

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
  String errorMessage = '';
  final auth = FirebaseAuth.instance;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  TextEditingController username = TextEditingController();
  TextEditingController regEmail = TextEditingController();
  TextEditingController regPassword = TextEditingController();
  TextEditingController regConfirmPassword = TextEditingController();

  void loginUser(context) async {
    try {
      await auth
          .signInWithEmailAndPassword(
          email: email.text, password: password.text)
          .then((value) =>
      {
        showDialog(context: context, builder: (context) {
          return Center(child: CircularProgressIndicator(),);
        }),
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (ctx) =>
                HomeScreen(email: 'admin', photoUrl: 'www', name: 'rakib',),
          ),
        ),
      });
      errorMessage = '';
    } on FirebaseAuthException catch (e) {
      errorMessage = e.message!;
      print(e);
    }
  }

  Future registerUser(context) async {
    try {
      if (regPassword.text != regConfirmPassword.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Confirm Password doesn't match"),
            backgroundColor: Colors.red,
          ),
        );
      }
      else {
        await auth.createUserWithEmailAndPassword(
            email: regEmail.text, password: regPassword.text).then((value) {
          showDialog(context: context, builder: (context) {
            return Center(child: CircularProgressIndicator(),);
          });
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (ctx) =>
                  HomeScreen(
                    email: regEmail.text,
                    photoUrl: 'www',
                    name: username.text,),
            ),
          );
          print('User is Registered');
          //else
        } //then

        );
      } //then
      errorMessage = '';
    } on FirebaseAuthException catch (e) {
      errorMessage = e.message!;
      print(e);
    }
  }
}

class Verification {
  final auth = FirebaseAuth.instance;

  Future<void> verifyPhoneNumber(String phoneNumber, BuildContext context) async {
    PhoneVerificationCompleted verificationCompleted = (PhoneAuthCredential phoneAuthCredential) async{
      showSnackBar(context, "Verification Completed");
    };
    PhoneVerificationFailed verificationFailed = (FirebaseAuthException exception){
      showSnackBar(context, exception.toString());
    };
    PhoneCodeSent codeSent = (String verificationID, [int? forceResendingtoken]){
      showSnackBar(context, "Verification code sent to the phone Number.");
    };
    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout = (String verificationID){
      showSnackBar(context, "Time Out");
    };
    try {
      await auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
  void showSnackBar(BuildContext context, String text){
    final snackBar = SnackBar(content: Text(text));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

  }
}