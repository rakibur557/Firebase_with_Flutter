import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple/services/googleServiceProvider.dart';
import 'HomeScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  googleServiceProvider googleService = googleServiceProvider();
  var obscureText = true; //password visibity controller

  @override
  Widget build(BuildContext context) {
    //EXIT CONTROLLER START HERE
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
      //SCAFFOLD DESIGN START HERE
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                //LOGIN SCREEEN IMAGE START HERE
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
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 35),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter your Email',
                      prefixIcon: Icon(Icons.mail),
                    ),
                  ),
                ),

                //PASSWORD FIELD START HERE
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                  child: TextField(
                    obscureText: obscureText,
                    decoration: InputDecoration(
                      hintText: 'Enter your Password',
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              obscureText = !obscureText;
                            });
                          },
                          child: obscureText
                              ? const Icon(
                                  Icons.visibility_off,
                                  color: Colors.grey,

                                )
                              : const Icon(
                                  Icons.visibility,
                                  color: Colors.green,
                                )),
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
                          await googleService.signInWithGoogle();
                          setState(() {
                            Navigator.pushReplacement(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => HomeScreen(
                                        email: googleService.email,
                                        name: googleService.name,
                                        photoUrl: googleService.photoUrl)));
                            //Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                          });
                        },
                        icon: Image.asset(
                          'assets/images/google.png',
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
