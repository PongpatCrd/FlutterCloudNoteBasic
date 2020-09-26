import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cloud_note/services/sign_in_service.dart';
import 'package:flutter_cloud_note/shared_materials/base_material.dart';

class SignInScreen extends StatefulWidget {
  final SignInService _signInService = SignInService();

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  Widget baseImageIconButton({@required String title, @required String imageName, @required Function doIt}) {
    return RaisedButton(
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none
      ),
      child: Row(
        children: <Widget>[
          Image.asset(
            'assets/icons/$imageName',
            height: 21,
          ),
          Flexible(
            fit: FlexFit.tight,
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
      onPressed: () { doIt(); }
    ); 
  }

  Widget _entryField(String title, {Widget icon, bool isPassword = false}) {
    return Theme(
      child: TextField(
        cursorColor: Colors.black,
        obscureText: isPassword,
        decoration: InputDecoration(
          fillColor: Colors.grey[100],
          filled: true,
          labelText: title,
          prefixIcon: icon,
          labelStyle: TextStyle(
            color: Colors.brown
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none
          ),
        ),
      ),
      data: ThemeData(
        primaryColor: Colors.deepOrange,
      ),
    );
  }

  Widget _normalSignInButton() {
    return baseImageIconButton(title: 'Sign in', imageName: 'app_icon.png', doIt: null);
  }

  Widget _googleSignInButton(BuildContext context) {
    Function function = () {
      widget._signInService.signInWithGoogle().then((user) {
        if (user != null) {
          Navigator.pushReplacementNamed(context, '/home');
        }
      });
    };

    return baseImageIconButton(title: 'Continune with google', imageName: 'google_logo.png', doIt: function);
  }

  Widget _guestSigInButton(BuildContext context) {
    return RaisedButton(
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none
      ),
      child: Text(
        'Continune as guest',
        style: TextStyle(
          fontWeight: FontWeight.bold
        ),
      ),
      onPressed: () {
        widget._signInService.signInWithGuest().then((user) {
          if (user != null) {
            Navigator.pushReplacementNamed(context, '/home');
          }
        });
      },
    );
  }

  Widget _signUpButton(BuildContext context) {
    return FlatButton(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Text(
        'Sign up',
        style: TextStyle(
          decoration: TextDecoration.underline,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: () {
        Navigator.pushNamed(context, '/sign_up');
      }
    );
  }

  bool _loadingActive = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: LoadingWrapper(
        loadingActive: _loadingActive,
        child: Scaffold(
          backgroundColor: Colors.yellow[50],
          body: SingleChildScrollView(
            child: SafeArea(
              child: Center(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.30,
                    ),
                    Container(
                      width: 400,
                      child: _entryField("Username", icon: Icon(Icons.person)),
                    ),
                    Container(
                      width: 400,
                      margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                      child: _entryField("Password", icon: Icon(Icons.lock), isPassword: true)
                    ),
                    Container(
                      width: 230,
                      margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                      child: _normalSignInButton(),
                    ),
                    Container(
                      width: 230,
                      margin: EdgeInsets.fromLTRB(0, 2, 0, 0),
                      child: _googleSignInButton(context),
                    ),
                    Container(
                      width: 230,
                      margin: EdgeInsets.fromLTRB(0, 2, 0, 0),
                      child: _guestSigInButton(context),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: _signUpButton(context),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );

  }
}