import 'package:flutter/material.dart';
import 'package:flutter_cloud_note/screens/login.dart';
import 'package:flutter_cloud_note/screens/splash_screen.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => SplashScreen(whenFinishGoToScreen: LoginScreen()),
    },
  ));
}
