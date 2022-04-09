import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:simple/pages/homeScreen.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
//import 'package:page_transition/page_transition.dart';
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
        //'/': (ctx) =>HomeScreen(),
        services.path: (ctx)=>services(),
      },
      home: AnimatedSplashScreen(
          duration: 3000,
          splash: 'assets/images/splashlogo.png',
          nextScreen: HomeScreen(),
          splashTransition: SplashTransition.fadeTransition,
      ),
    );
  }
}
