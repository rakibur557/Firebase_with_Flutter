import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);
  static const String path = "RegisterPage";

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var obscureText = true; //password visibity controller
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
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
                  padding: const EdgeInsets.only(top: 30.0),
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
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                  child: TextField(
                   // controller: registerLoginAuth.email,
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
                    // controller: registerLoginAuth.email,
                    decoration: InputDecoration(
                      hintText: 'Enter your email',
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                  ),
                ),
//PASSWORD FIELD HERE
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                  child: TextField(
                    //controller: registerLoginAuth.password,
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
//CONFIRM PASSWORD FIELD HERE
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 0),
                  child: TextField(
                    //controller: registerLoginAuth.password,
                    obscureText: obscureText,
                    decoration: InputDecoration(
                      hintText: 'Confirm Password',
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

              ],
            ),
          ),
        ),
      ),
    );
  }
}
