import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertodoapplication/models/user.dart';

class AuthService{

	final FirebaseAuth _auth = FirebaseAuth.instance;

	//create user object based on Firbase
	User _userFromFirebaseUser(FirebaseUser user){
		return user != null ? User(uid: user.uid) : null;
	}

	//auth change user stream
	Stream<User> get user{
		return _auth.onAuthStateChanged.map((_userFromFirebaseUser));
	}

	//sign in anon
	Future signInAnon() async{
		try{
		  AuthResult result = await _auth.signInAnonymously();
		  FirebaseUser user = result.user;
		  return _userFromFirebaseUser(user);
		} catch (e){
			print(e.toString());
			return null;
		}
	}
	//sign in email and password

	//register email and password

	//sign out
	Future signOut() async{
		try{
			return await _auth.signOut();
		} catch(e){
			print(e);
		}
	}
}