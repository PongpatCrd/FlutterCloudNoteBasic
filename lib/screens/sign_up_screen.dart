import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  Widget _entryField(String title, {bool isPassword = false}) {
    return Theme(
      child: TextFormField(
        cursorColor: Colors.black,
        obscureText: isPassword,
        validator: (String text) {
          if (text.isEmpty) {
            return 'fill some thing';
          }
          else {
            return null;
          }
        },
        decoration: InputDecoration(
          fillColor: Colors.grey[100],
          filled: true,
          labelText: title,
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

  Widget _signupButton() {
    return RaisedButton(
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none
      ),
      child: Text(
        'Sign Up',
        style: TextStyle(
          fontWeight: FontWeight.bold
        ),
      ),
      onPressed: () {

      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[50],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Form(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.25,
                  ),
                  Container(
                    width: 320,
                    child: _entryField('Username'),
                  ),
                  Container(
                    width: 320,
                    margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                    child: _entryField('Password'),
                  ),
                  Container(
                    width: 320,
                    margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                    child: _entryField('Display Name'),
                  ),
                  Container(
                    width: 320,
                    margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                    child: _entryField('Email'),
                  ),
                  Container(
                    width: 320,
                    margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                    child: _entryField('Username'),
                  ),
                  Container(
                    width: 230,
                    margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                    child: _signupButton(),
                  ),
                ],
              ),
            )
          )
        ),
      ),
    );
  }
}
