import 'package:flutter/material.dart';
import 'package:fluttertodoapplication/services/auth.dart';
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

  	final AuthService _auth = AuthService();

    return Scaffold(
			backgroundColor: Colors.white,
			appBar: AppBar(
				title: Text('TODO'),
				elevation: 0,
				actions: <Widget>[
					FlatButton.icon(
						icon: Icon(Icons.person),
						onPressed: () async {
							await _auth.signOut();
						},
						label: Text('logout'),
					)
				],
			),
		);
  }
}
