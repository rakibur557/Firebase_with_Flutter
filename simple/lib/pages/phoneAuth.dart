
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:simple/services/googleServiceProvider.dart';
class PhoneAuthPage extends StatefulWidget {
  const PhoneAuthPage({Key? key}) : super(key: key);
  static const String path = "PhoneAuthPage";
  @override
  State<PhoneAuthPage> createState() => _PhoneAuthPageState();
}

class _PhoneAuthPageState extends State<PhoneAuthPage> {
  int start = 30;
  bool wait = false;
  String buttonName = "Send";
  TextEditingController phoneController = TextEditingController();
  Verification verification = Verification();
  String verificationId ="";
  String smsCode = "";
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
              ),
              SizedBox(
                height: 40,
              ),
              RichText(text: TextSpan(
                children: [
                  TextSpan(
                  text: "Send OTP again in ",
                  style: TextStyle(color: Colors.blue,
                  ),),
                  TextSpan(
                    text: "$start",
                    style: TextStyle(color: Colors.red,
                    ),),
                  TextSpan(
                    text: " sec.",
                    style: TextStyle(color: Colors.blue,
                    ),),
                ],
              ),),
              SizedBox(
                height: 40,
              ),
              ElevatedButton(onPressed: (){}, child: Text('Login'),style: ElevatedButton.styleFrom(padding: EdgeInsets.only(right: 100, left: 100)),),
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
          wait = false;
        });
      }
      else{
        setState(() {
          start--; //ok
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
            child: Text( "(+880)", style: TextStyle(color: Colors.black, fontSize: 17,),
          ),
        ),
          suffixIcon: GestureDetector(
            onTap: wait? null : () async{
              startTimer();
              setState(() {
                start = 30;
                wait = true;
                buttonName = "Resend";
              });
              await verification.verifyPhoneNumber("${phoneController.text})", context, setdata);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14,horizontal: 15),
              child: Text(buttonName, style: TextStyle(color: wait? Colors.grey : Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
      ),
    ));
  }
  void setdata(){
    setState(() {
      verificationId = verificationId;
    });
    startTimer();
  }
}
