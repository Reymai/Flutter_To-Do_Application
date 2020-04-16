import 'package:flutter/material.dart';
import 'package:fluttertodoapplication/models/user.dart';
import 'package:fluttertodoapplication/screens/authenticate/autenticate.dart';
import 'package:fluttertodoapplication/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

  	final user = Provider.of<User>(context);

  	if (user == null){
			return Authenticate();
		} else {
  		return Home();
		}
    //return Home or Authenticate widget
  }
}
