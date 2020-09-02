import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  
  final StatefulWidget whenFinishGoToScreen;
  SplashScreen({@required this.whenFinishGoToScreen});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  @override
  void initState() {
    super.initState();
    
    Timer(Duration(seconds: 2, milliseconds: 700), () =>
      Navigator.pushReplacement(context, 
        MaterialPageRoute(builder: (context) => widget.whenFinishGoToScreen))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white, 
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
              child: Image.asset('assets/images/cat_gif1.gif')
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
    );
  }
}