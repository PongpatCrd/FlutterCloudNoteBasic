import 'package:flutter/material.dart';
import 'package:flutter_cloud_note/screens/home_screen.dart';
import 'package:flutter_cloud_note/screens/sign_in_screen.dart';
import 'package:flutter_cloud_note/screens/sign_up_screen.dart';
import 'package:flutter_cloud_note/screens/splash_screen.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => SplashScreen(),
      '/home': (context) => HomeScreen(),
      '/sign_in': (context) => SignInScreen(),
      '/sign_up': (context) => SignUpScreen(),
    },
  ));
}

// test
// void main() {
//   runApp(MaterialApp(
//     initialRoute: '/sign_in',
//     routes: {
//       '/home': (context) => HomeScreen(),
//       '/sign_in': (context) => SignInScreen(),
//       '/sign_up': (context) => SignUpScreen(),
//     },
//   ));
// }