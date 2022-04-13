import 'package:flutter/material.dart';
import 'package:simple/services/googleServiceProvider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);
  static const String path = "RegisterPage";

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  RegisterLoginAuth registerLoginAuth = RegisterLoginAuth();

  var obscureText = true; //password visibity controller
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
//APPBAR SECTION
      appBar: AppBar(
        leading: GestureDetector(
          child: Icon( Icons.arrow_back_ios, color: Colors.black,  ),
          onTap: () {
            Navigator.pop(context);
          } ,
        ) ,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text('Back', style: TextStyle(color: Colors.black),),
        titleSpacing: 0,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
//CREATE ACCOUNT HEADING
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: CircleAvatar(child: Icon(Icons.person)),
                ),
                Text(
                  'Create Account',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Create a new account',
                  style: TextStyle(
                    // fontWeight: FontWeight.bold,
                    // fontSize: 25,
                    color: Colors.grey,
                  ),
                ),
//NAME FIELD HERE
                Padding(
                  padding: EdgeInsets.only(right: 25, left: 25, bottom: 20, top: 30,),
                  child: TextField(
                    controller: registerLoginAuth.username,
                    decoration: InputDecoration(
                      hintText: 'Enter your name',
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                  ),
                ),
//EMAIL FIELD HERE
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 0),
                  child: TextField(
                  controller: registerLoginAuth.regEmail,
                    decoration: InputDecoration(
                      hintText: 'Enter your email',
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                  ),
                ),
//PASSWORD FIELD HERE
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                  child: TextField(
                    controller: registerLoginAuth.regPassword,
                    obscureText: obscureText,
                    decoration: InputDecoration(
                      hintText: 'Enter your Password',
                      prefixIcon: Icon(Icons.lock_outline),
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
//CONFIRM PASSWORD FIELD HERE
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 0),
                  child: TextField(
                    controller: registerLoginAuth.regConfirmPassword,
                    obscureText: obscureText,
                    decoration: InputDecoration(
                      hintText: 'Confirm Password',
                      prefixIcon: Icon(Icons.lock_outlined),
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
//TERMS AND CONDITIONS
                Padding(
                  padding: EdgeInsets.only(left: 25, right: 25, top: 30,bottom: 0,),
                  child: Text(
                    "By Signing Up you agreed to our terms, conditions and privacy policy.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                      ),
                    ),
                  ),

//REGISTER BUTTON START HERE
                Padding(
                  padding: const EdgeInsets.only(
                      top: 30, bottom: 20, left: 30, right: 30),
                  child: Container(
                    height: 40,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                      ),
                      onPressed: () {
                        if(registerLoginAuth.regEmail != '' && registerLoginAuth.regPassword !=''){
                          registerLoginAuth.registerUser(context);
                        }
                        setState(() {
                          if(registerLoginAuth.errorMessage=='Given String is empty or null'){
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                //  content: Text('${registerLoginAuth.errorMessage}'),
                                content: Text('Please provide information for all required fields'),
                                backgroundColor: Colors.red,

                              ),
                            );
                          }
                          else{
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                //  content: Text('${registerLoginAuth.errorMessage}'),
                                content: Text('${registerLoginAuth.errorMessage}'),
                              ),
                            );
                          }
                        });
                      },
                      child: const Text('REGISTER', style: TextStyle(color: Colors.white)),
                    ),
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
