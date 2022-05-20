
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
class PhoneAuthPage extends StatefulWidget {
  const PhoneAuthPage({Key? key}) : super(key: key);
  static const String path = "PhoneAuthPage";
  @override
  State<PhoneAuthPage> createState() => _PhoneAuthPageState();
}

class _PhoneAuthPageState extends State<PhoneAuthPage> {
  int start = 30;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Sign Up'),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 150,),
              textfield(),
              SizedBox(height: 50,),
// OTP BOX
              OTPTextField(
                length: 5,
                width: MediaQuery.of(context).size.width,
                fieldWidth: 50,
                style: TextStyle(
                    fontSize: 17
                ),
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldStyle: FieldStyle.box,
                onCompleted: (pin) {
                  print("Completed: " + pin);
                },
              )

            ],
          ),
        ),
      ),
    );
  }

  void startTimer(){
    const onsec = Duration(seconds: 1);
    Timer timer = Timer.periodic(onsec, (timer) {
      if(start==0){
        setState(() {
          timer.cancel();
        });
      }
      else{
        setState(() {
          start--;
        });
      }
    });
  }
  Widget textfield(){
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      decoration: BoxDecoration(
        //color: Colors.deepPurple,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          hintText: "Enter your Phone Number",
          hintStyle: TextStyle(color: Colors.black38, fontSize: 17),
          contentPadding: const EdgeInsets.symmetric(vertical: 19, horizontal: 8),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14,horizontal: 15),
            child: Text("(+880)", style: TextStyle(color: Colors.black, fontSize: 17,),
          ),
        ),
          suffixIcon: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14,horizontal: 15),
            child: Text("Send", style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
      ),
    ));
  }
}
/*
Widget otpField(){
  return OTPTextField(
    length: 5,
    width: MediaQuery.of(context).size.width,
    fieldWidth: 80,
    style: TextStyle(
        fontSize: 17
    ),
    textFieldAlignment: MainAxisAlignment.spaceAround,
    fieldStyle: FieldStyle.underline,
    onCompleted: (pin) {
      print("Completed: " + pin);
    },
  );
}
*/