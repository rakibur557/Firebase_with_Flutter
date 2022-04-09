import 'package:flutter/material.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
                  children: [
                    Image.asset('assets/images/login.png'),
                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: TextField(
                        cursorColor: Colors.black,

                        decoration: InputDecoration(
                          hintText: 'Enter your Email',
                          prefixIcon: Icon(Icons.mail),
                        ),

                      ),
                    ),
                  ],
                ),
          ),
        ),
    );
  }
}
