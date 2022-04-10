import 'dart:html';

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
              SizedBox(
                height: 15,
              ),
              Text(
                'Log In',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter your Email',
                    prefixIcon: Icon(Icons.mail),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Enter your Password',
                    prefixIcon: Icon(Icons.mail),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
