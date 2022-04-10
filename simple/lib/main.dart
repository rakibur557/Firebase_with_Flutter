import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:simple/pages/LoginScreen.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'pages/HomeScreen.dart';
import 'services/services.dart';

Future<void> main()async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

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
        services.path: (ctx)=>HomeScreen(),
      },
      home: AnimatedSplashScreen(
          duration: 3000,
          splash: 'assets/images/splashlogo.png',
          nextScreen: LoginScreen(),
          splashTransition: SplashTransition.fadeTransition,
      ),
    );
  }
}
