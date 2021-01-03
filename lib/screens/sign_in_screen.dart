import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_cloud_note/services/helper_service.dart';
import 'package:flutter_cloud_note/services/sign_in_service.dart';
import 'package:flutter_cloud_note/shared_materials/base_material.dart';

class SignInScreen extends StatefulWidget {
  
  final SignInService _signInService = SignInService();
  final HelperService _helperService = HelperService();

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  final _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  
  bool _loadingActive = false;
  

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.landscapeRight,
    //   DeviceOrientation.landscapeLeft,
    //   DeviceOrientation.portraitUp,
    //   DeviceOrientation.portraitDown,
    // ]);
    
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.30,
                      ),
                      Container(
                        width: 340,
                        child: _entryFormField(
                          "Username", 
                          icon: Icon(Icons.person),
                          controller: _usernameController,
                          validator: _usernameValidator,
                        ),
                      ),
                      Container(
                        width: 340,
                        margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                        child: _entryFormField(
                          "Password", 
                          icon: Icon(Icons.lock), 
                          isPassword: true,
                          controller: _passwordController,
                          validator: _passwordValidator,
                        )
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
      ),
    );

  }

  Widget _baseImageIconButton({@required String title, @required String imageName, @required Function onPressed}) {
    return RaisedButton(
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none
      ),
      child: Row(
        children: <Widget>[
          Image.asset(
            'assets/icons/$imageName',
            height: 24,
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
      onPressed: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        currentFocus.unfocus();

        onPressed();
      }
    ); 
  }

  Widget _entryFormField(String title, {Widget icon, bool isPassword = false, @required TextEditingController controller, Function validator}) {
    return Theme(
      child: TextFormField(
        controller: controller,
        cursorColor: Colors.black,
        obscureText: isPassword,
        validator: validator,
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
    return _baseImageIconButton(
      title: 'Sign in', 
      imageName: 'app_icon.png', 
      onPressed: () async {
        if (_formKey.currentState.validate()) {
          setState(() {
            _loadingActive = true;
          });

          var authResult;
          try {
            authResult = await widget._signInService.authUser({
              "username"       : _usernameController.text,
              "password"       : _passwordController.text,
            });
          }
          catch (error) {
            setState(() {
              _loadingActive = false;
            });

            widget._helperService.showAlertDialog(context, 'Something went wrong, try again later.');
            return;
          }

          if (authResult['success']) {
            Navigator.pushReplacementNamed(context, '/home');
          }
          else {
            setState(() {
              _loadingActive = false;
            });
            widget._helperService.showAlertDialog(context, authResult['msg']);
          }
        }
        else {
          setState(() {
            _loadingActive = false;
          });
        }
      }
    );
  }

  Widget _googleSignInButton(BuildContext context) {
    Function function = () {
      widget._signInService.signInWithGoogle().then((user) {
        if (user != null) {
          Navigator.pushReplacementNamed(context, '/home');
        }
      });
    };

    return _baseImageIconButton(title: 'Continune with google', imageName: 'google_logo.png', onPressed: function);
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
}

  String _usernameValidator(String text) {
    if (text.isEmpty) {
      return 'Username must not empty';
    }
    else if(text.length < 6){
      return 'Username have to longer or equal to 6 character';
    }
    else if(text.length > 20){
      return 'Username have to lower or equal than 20 character';
    }
    else{
      return null;
    }
  }

  String _passwordValidator(String text) {
    if (text.isEmpty) {
      return 'Password must not empty';
    }
    else if(text.length < 8) {
      return 'Password have to longer or equal than 8 character';
    }
    else if(text.length > 20) {
      return 'Password have to lower or equal than 20 character';
    }
    else{
      return null;
    }
  }
