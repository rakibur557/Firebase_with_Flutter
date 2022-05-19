import 'package:flutter/material.dart';
class PhoneAuthPage extends StatefulWidget {
  const PhoneAuthPage({Key? key}) : super(key: key);
  static const String path = "PhoneAuthPage";
  @override
  State<PhoneAuthPage> createState() => _PhoneAuthPageState();
}

class _PhoneAuthPageState extends State<PhoneAuthPage> {
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
              SizedBox(height: 40,),
              textfield(),
            ],
          ),
        ),
      ),
    );
  }
  Widget textfield(){
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      decoration: BoxDecoration(
        //color: Colors.green,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Enter your Phone Number",
          hintStyle: TextStyle(color: Colors.black38, fontSize: 17),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("(+880)", style: TextStyle(color: Colors.black, fontSize: 17,),
          ),
        ),
      ),
    ));
  }
}
