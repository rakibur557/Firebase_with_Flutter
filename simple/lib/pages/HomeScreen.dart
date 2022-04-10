import 'package:flutter/material.dart';
class HomeScreen extends StatelessWidget {
  static const String path = "HomeScreen";
  String email, name;
  

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Elite APP'),
        centerTitle: true,

      ),
    );
  }
}
