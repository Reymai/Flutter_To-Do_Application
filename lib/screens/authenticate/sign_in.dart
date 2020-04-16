import 'package:flutter/material.dart';
import 'package:fluttertodoapplication/screens/home/home.dart';
import 'package:fluttertodoapplication/services/auth.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

	final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
			backgroundColor: Colors.white,
			appBar: AppBar(
				backgroundColor: Colors.blue,
				elevation: 0.0,
				title: Text('Sign in'),
			),
			body: Container(
				padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
				child: RaisedButton(
					child: Text('Sign in anonymously'),
					onPressed: () async{
						dynamic result = await _authService.signInAnon();
						if(result == null){
							print('Error');
						} else{
							print(result.uid);
							print('signed in');
						}
					},
				),
			),
		);
  }
}
