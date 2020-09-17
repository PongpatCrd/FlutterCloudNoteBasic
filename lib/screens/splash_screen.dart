import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_note/services/sign_in_service.dart';

class SplashScreen extends StatefulWidget {
  
  // final StatefulWidget whenFinishGoToScreen;
  // SplashScreen({@required this.whenFinishGoToScreen});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  @override
  void initState() {
    super.initState();
  
    SignInService().getUId().then((uid) {
      print(uid);
      Timer(Duration(seconds: 3, milliseconds: 500), () {
        if(uid != null) {
          Navigator.pushReplacementNamed(context, '/home');
        }
        else {
          Navigator.pushReplacementNamed(context, '/sign_in');
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white, 
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              Container(
                alignment: Alignment(0, -0.65),
                child: Text(
                  'Note Me!',
                  style: TextStyle(
                    fontSize: 55.0,
                    fontFamily: 'Pacifico-Regular',
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Image.asset('assets/images/edited_logo.gif')
              ),
              Container(
                alignment: Alignment(0, 0.75),
                child: Text(
                  'By Pongpat Choorod',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.grey[500]
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
