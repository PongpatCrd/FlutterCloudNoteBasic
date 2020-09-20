import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';
import 'package:flutter_cloud_note/services/helper_service.dart';
import 'package:flutter_cloud_note/services/sign_up_service.dart';
import 'package:flutter_cloud_note/shared_materials/base_material.dart';

class SignUpScreen extends StatefulWidget {

  final SignUpService _signUpService = SignUpService();
  final HelperService _helperService = HelperService();

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final _formKey = GlobalKey<FormState>();

  final _usernameController        = TextEditingController();
  final _passwordController        = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _displayNameController     = TextEditingController();
  final _emailController           = TextEditingController();
  
  String _errorMsg;
  Function _alertSetStateFunction;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.yellow[50],
        body: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    AlertBar(
                      errorMsg: _errorMsg, 
                      alertSetStateFunction: _alertSetStateFunction
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.25,
                    ),
                    Container(
                      width: 320,
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: _entryFormField(
                        'Username',
                        controller: _usernameController,
                        validator: _usernameValidator,
                      ),
                    ),
                    Container(
                      width: 320,
                      margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                      child: _entryFormField(
                        'Password',
                        isPassword: true,
                        controller: _passwordController,
                        validator: _passwordValidator,
                      ),
                    ),
                    Container(
                      width: 320,
                      margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                      child: _entryFormField(
                        'Confirm Password',
                        isPassword: true,
                        controller: _confirmPasswordController,
                      ),
                    ),
                    Container(
                      width: 320,
                      margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                      child: _entryFormField(
                        'Display Name',
                        controller: _displayNameController,
                        validator: _displayNameValidator,
                      ),
                    ),
                    Container(
                      width: 320,
                      margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                      child: _entryFormField(
                        'Email',
                        controller: _emailController,
                        validator: _emailValidator,
                      ),
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
      ),
    );
  }

  Widget _entryFormField(String title, {bool isPassword = false, @required TextEditingController controller, Function validator}) {
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
      onPressed: () async {
        FocusScopeNode currentFocus = FocusScope.of(context);
        currentFocus.unfocus();

        if (_formKey.currentState.validate()) {

          var resCreateUser = await widget._signUpService.createUser({
            "username"       : _usernameController.text,
            "password"       : _passwordController.text,
            "display_name"   : _displayNameController.text,
            "email"          : _emailController.text,
            });

          print(resCreateUser);

          if (resCreateUser['success']) {
            var user = resCreateUser['data']['user'];
            var userProfile = resCreateUser['data']['userProfile'];

            String activeUserUrl = widget._signUpService.createActiveUserUrl(user['uid']);

            String content = '''
            <h1>
              You use email <p style="color: red;">${userProfile['email']}</p> sign up to Note Me.
            </h1>
            <p>
              Is that is you? Please confirm to complete this action.
            </p>
            <p>
              Click this link to confirm <a href="$activeUserUrl">$activeUserUrl</a>
            </p>
            ''';

            var resSendEmail = await widget._helperService.sendEmail({
              'to_email': userProfile['email'],
              'subject' : 'Confirm your email address to use Note Me',
              'content' : content,
            });

            Navigator.pushReplacementNamed(context, '/sign_in');

          }
          else{
            setState(() {
              _errorMsg = resCreateUser['msg'];
              _alertSetStateFunction = () {
                // for make Alert().alertBar can close with icon
                setState(() {
                  _errorMsg = null;
                });
              };
            });
          }
        }
        else {
          setState(() {
            _errorMsg = "Please correct form data.";
            _alertSetStateFunction = () {
              // for make Alert().alertBar can close with icon
              setState(() {
                _errorMsg = null;
              });
            };
          });
        }
      },
    );
  }

  String _usernameValidator(String text) {
    final validCharacters = RegExp(r'^([a-zA-Z0-9]+_)*[a-zA-Z0-9]+$');

    if (text.isEmpty) {
      return 'Username must not empty';
    }
    else if(text.length < 6){
      return 'Username have to longer or equal to 6 character';
    }
    else if(text.length > 20){
      return 'Username have to lower or equal than 20 character';
    }
    else if(!validCharacters.hasMatch(text)){
      return 'Invalid format, Please follow valid format a-z, A-Z, 0-9, _';
    }
    else{
      return null;
    }
  }

  String _passwordValidator(String text) {
    final validCharacters = RegExp(r'^([a-zA-Z0-9]+_)*[a-zA-Z0-9]+$');

    if (text.isEmpty) {
      return 'Password must not empty';
    }
    else if(text.length < 8) {
      return 'Password have to longer or equal than 8 character';
    }
    else if(text.length > 20) {
      return 'Password have to lower or equal than 20 character';
    }
    else if(text != _confirmPasswordController.text) {
      return 'Password and Confirm Password not match';
    }
    else if(!validCharacters.hasMatch(text)){
      return 'Invalid format, Please follow valid format a-z, A-Z, 0-9, _';
    }
    else{
      return null;
    }
  }

  String _displayNameValidator(String text) {
    final validCharacters = RegExp(r'^[a-zA-Z0-9_@.\s]+$');

    if (text.isEmpty) {
      return 'Display name must not empty';
    }
    else if(text.length > 20){
      return 'Password have to lower or equal than 20 character';
    }
    else if(!validCharacters.hasMatch(text)){
      return "Invalid format, Please don't use special character";
    }
    else{
      return null;
    }
  }

  String _emailValidator(String text) {
    if (text.isEmpty) {
      return 'Email must not empty';
    }
    else if(!isEmail(text)){
      return 'Invalid format for email';
    }
    else{
      return null;
    }
  }
  
}
