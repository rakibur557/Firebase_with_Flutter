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
  RegisterLoginAuth registerLoginAuth = RegisterLoginAuth();
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
//LOGIN SCREEEN IMAGE HERE
                Image.asset('assets/images/login.png'),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  'SIGN IN',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),

//EMAIL FIELD START HERE
                 Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 35),
                  child: TextField(
                    controller: registerLoginAuth.email,
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
                    controller: registerLoginAuth.password,
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
//FORGET PASSWORD
                Padding(
                  padding: const EdgeInsets.only(top: 10, right: 30),
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        'Forgot password?',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ]),
                ),
//LOGIN BUTTON START HERE
                Padding(
                  padding: const EdgeInsets.only(
                      top: 30, bottom: 20, left: 30, right: 30),
                  child: Container(
                    height: 40,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                      ),
                      onPressed: () {
                        if(registerLoginAuth.email != '' && registerLoginAuth.password !=''){
                          registerLoginAuth.loginUser(context);
                        }
                      },
                      child: const Text('LOGIN'),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
//REGISTER SECTION HERE
                    const Text("Don't you have any account? "),
                    GestureDetector(
                      onTap: (){
                        Navigator.of(context).pushNamed('/registerRoute');
                      },
                      child: const Text("Resigter Now", style: TextStyle(
                        // decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,

                      ),),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text('- Or Signin with -'),
                const SizedBox(
                  height: 15,
                ),
//SIGNIN WITH GOOGLE AND PHONE
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
// PHONE VARIFICATION SECTION
                    IconButton(
                        onPressed: () {},
                        icon: Image.asset(
                          'assets/images/telephone.png',
                        )),
// GOOGLE AUTHENTICATION SECTION
                    IconButton(
                        onPressed: () async {
                          showDialog(context: context, builder: (context){
                            return Center(child: CircularProgressIndicator(),);
                          });
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
//FACEBOOK AUTHENTICATION SECTION
                    IconButton(
                        onPressed: () {},
                        icon: Image.asset(
                          'assets/images/facebook.png',
                        )),
                  ],
                ),
//FOOTER SECTION
                SizedBox(height: 15,),
                Text(
                  "Terms & Conditions applied",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
