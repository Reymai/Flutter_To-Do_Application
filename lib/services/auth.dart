import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertodoapplication/models/user.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: [
    'openid',
    'email',
    'profile',
  ]);

  //create user object based on Firbase
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map((_userFromFirebaseUser));
  }

  //sign in or sign up
  Future isRegistred(String email, String password) async{
    dynamic result = await signInWithEmailAndPassword(email, password);
    String textResult = result.toString();
    print(textResult);

    if(textResult.contains('ERROR_WRONG_PASSWORD')){
      return false;
    } else if(textResult.contains('ERROR_USER_NOT_FOUND')){
      return true;
    } else {
      print(textResult);
      return textResult;
    }
  }

  //sign in anon
  Future signInAnon() async {
    final String name = 'Anonym';
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      await DatabaseService(uid: user.uid).updateUserData(name);
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e);
      return e;
    }
  }

  //register email and password
  Future registerWithEmailAndPassword(
      String email, String password, String name) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;

      //create a new document for the user with the uid
      await DatabaseService(uid: user.uid).updateUserData(name);
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in with Google account
  Future signInGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    try {
      final AuthCredential credential = GoogleAuthProvider.getCredential(
          idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
      final FirebaseUser user =
          (await _auth.signInWithCredential(credential)).user;
      //create a new document for the user with the uid
      await DatabaseService(uid: user.uid).updateUserData(user.displayName);
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e);
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e);
    }
  }
}
