import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:flutter_cloud_note/services/base_service.dart';
import 'package:flutter_cloud_note/configs.dart';


class SignInService {

  final BaseService _baseService = BaseService();
  final Configs _configs = Configs();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<dynamic> signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final AuthResult authResult = await _auth.signInWithCredential(credential);
      final FirebaseUser user = authResult.user;
      
      return user;
    }
    catch (e) {
      return null;
    }
  }

  Future<dynamic> signInWithGuest() async {
    AuthResult user = await _auth.signInAnonymously();
    return user;
  }

  Future<String> getUId() async {
    final FirebaseUser user = await _auth.currentUser();
    
    String uid;
    if(user != null) {
      uid = user.uid.toString();
    }
    return uid;
  }

  // use for in app sign up
  Future authUser(Map<String, dynamic> dataMap) async {
    print(dataMap);
    var res = _baseService.basePostRequest(dynamicUrl: _configs.authUserUrl, dataMap: dataMap);
    return res;
  }

  void signOut() async {
    await _auth.signOut();
    await googleSignIn.signOut();
  }
}
