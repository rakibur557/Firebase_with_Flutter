import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:simple/pages/homeScreen.dart';

import 'services/services.dart';

void main() => runApp(const MyApp());


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (ctx) =>HomeScreen(),
        services.path: (ctx)=>services(),
      },
    );
  }
}
