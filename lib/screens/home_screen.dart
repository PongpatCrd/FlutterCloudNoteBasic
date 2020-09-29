import 'package:flutter/material.dart';
import 'package:flutter_cloud_note/services/sign_in_service.dart';

class HomeScreen extends StatefulWidget {
  final SignInService _signInService  = SignInService();

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RaisedButton(
          child: Text(
            'Logout'
          ),
          onPressed: () {
            widget._signInService.signOut();
            
            widget._signInService.getUId().then((uid) {
              print(uid);
              Navigator.of(context).pushNamedAndRemoveUntil(
                '/sign_in',
                (Route<dynamic> route) => false
              );
            });
          }
        ),
      ),
    );
  }
}
