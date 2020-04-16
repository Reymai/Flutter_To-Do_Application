import 'package:flutter/material.dart';
import 'package:fluttertodoapplication/models/user.dart';
import 'package:fluttertodoapplication/screens/wrapper.dart';
import 'package:fluttertodoapplication/services/auth.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
	
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}