import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

//import 'package:simple/pages/HomeScreen.dart';
import 'HomeScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  ///late GoogleSignInAccount userobj;
  //GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
  // Future signInProcess() async{
  //   final GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();
  //   final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;
  //   AuthCredential credential = GoogleAuthProvider.credential(idToken: googleSignInAuthentication.idToken, accessToken: googleSignInAuthentication.accessToken );
  //   UserCredential result = await FirebaseAuth.instance.signInWithCredential(credential);
  //   User? user = result.user;
  //
  //   if(user != null){
  //     print('IF IS WORKING');
  //     Navigator.push(context, CupertinoPageRoute(builder: (context)=>HomeScreen()));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // GoogleSignInAccount? user = googleSignIn.currentUser;
    return WillPopScope(
      onWillPop: () async {
        final value = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Alert'),
                content: const Text('Are you sure want to exit?'),
                actions: [
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text('No'),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text('Yes'),
                  ),
                ],
              );
            });
        if (value != null) {
          return Future.value(value);
        } else {
          return Future.value(false);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset('assets/images/login.png'),
                const SizedBox(
                  height: 25,
                ),
                const Text(
                  'SIGN IN',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                //EMAIL FIELD START HERE
                const Padding(
                  padding:
                       EdgeInsets.symmetric(horizontal: 30, vertical: 35),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter your Email',
                      prefixIcon: Icon(Icons.mail),
                    ),
                  ),
                ),

                //PASSWORD FIELD START HERE
                const Padding(
                  padding:
                       EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Enter your Password',
                      prefixIcon: Icon(Icons.key),
                    ),
                  ),
                ),

                //LOGIN BUTTON START HERE
                Padding(
                  padding: const EdgeInsets.only(
                      top: 45, bottom: 20, left: 30, right: 30),
                  child: Container(
                    height: 40,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                      ),
                      onPressed: () {},
                      child: const Text('LOGIN'),
                    ),
                  ),
                ),
                const Text('- Signin with -'),
                const SizedBox(
                  height: 15,
                ),
                //SIGNIN WITH GOOGLE AND PHONE
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // PHONE SECTION
                    IconButton(
                        onPressed: () {},
                        icon: Image.asset(
                          'assets/images/telephone.png',
                        )),
                    // GOOGLE SECTION
                    IconButton(
                        onPressed: () async {
                          await signInWithGoogle();
                          setState(() {
                            Navigator.pushReplacement(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => HomeScreen()));
                            //Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                          });
                          // await GoogleSignIn().signIn().then((value) {
                          //   setState(() {
                          //     //userobj = value!;
                          //   });
                          // });
                        },
                        icon: Image.asset(
                          'assets/images/google.png',
                        )),
                  ],
                ),

/*
                //GOOGLE BUTTON START HERE
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 15, left: 30, right: 30),
                  child: Container(
                    height: 40,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                      ),
                      onPressed: () {},
                      child: Text('Sign in with Google'),
                    ),
                  ),
                ),

                //PHONE BUTTON START HERE
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 15, left: 30, right: 30),
                  child: Container(
                    height: 40,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                      ),
                      onPressed: () {},
                      child: Text('Sign in with Phone'),
                    ),
                  ),
                ),
*/
              ],
            ),
          ),
        ),
      ),
    );
  }

  //----------------
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

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
