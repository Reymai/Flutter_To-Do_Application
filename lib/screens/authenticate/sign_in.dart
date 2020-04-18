import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:fluttertodoapplication/services/auth.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  TextEditingController _controller = TextEditingController();

  //text field states
  String email = '';
  String password = '';
  String name = '';

  bool _autoValidate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0.0,
        title: Text('Sign in'),
      ),
      body: Builder(builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 10),
                //Email
                TextFormField(
                  autovalidate: _autoValidate,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    filled: true,
                  ),
                  validator: (value) => !EmailValidator.validate(value)
                      ? 'Enter a correct email'
                      : null,
                  onChanged: (value) {
                    setState(() => email = value);
                  },
                ),
                SizedBox(height: 5),
                //Password
                TextFormField(
                  autovalidate: _autoValidate,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    filled: true,
                    counter: counter(context,
                        currentLength: password.length,
                        minLength: 6,
                        maxLength: 32),
                  ),
                  validator: (value) => value.length < 6 ? '' : null,
                  obscureText: true,
                  onChanged: (value) {
                    setState(() => password = value);
                  },
                ),
                SizedBox(height: 15),
                SignInButton(
                  Buttons.Email,
                  onPressed: () async {
                    setState(() => _autoValidate = true);
                    if (_formKey.currentState.validate()) {
                      print(email);
                      print(password);
                      dynamic result =
                          await _authService.isRegistred(email, password);
                      print(result);
                      if (result == false) {
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text('Wrong password!'),
                        ));
                      } else if (result == true) {
                        showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (_) => AlertDialog(
                                  title: Text('We did not find your account'),
                                  content: Text(
                                      'Would you like us to register you?'),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text('No'),
                                      onPressed: () {
                                        Navigator.of(context, rootNavigator: true).pop(result);
                                      },
                                    ),
                                    FlatButton(
                                      child: Text('Yes'),
                                      onPressed: () {
                                        Navigator.of(context, rootNavigator: true).pop(result);
                                        showDialog(
                                          context: context,
                                          barrierDismissible: true,
                                          builder: (_) => AlertDialog(
                                            title: Text('What is your name?'),
                                            content: Form(
                                              child: TextFormField(
                                                decoration: InputDecoration(
                                                  labelText: 'Name',
                                                  filled: true,
                                                ),
                                                validator: (name) =>
                                                    name.isEmpty
                                                        ? 'Enter Your name'
                                                        : null,
                                                onChanged: (value) {
                                                  setState(() => name = value);
                                                },
                                              ),
                                            ),
                                            actions: <Widget>[
                                              FlatButton(
                                                  child: Text('Cancel'),
                                                  onPressed: (){
                                                    Navigator.of(context, rootNavigator: true).pop(result);
                                                  },
                                              ),
                                              FlatButton(
                                                  child: Text('Registr me!'),
                                                  onPressed: (){
                                                    Navigator.of(context, rootNavigator: true).pop(result);
                                                    _authService.registerWithEmailAndPassword(email, password, name);
                                                    },
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                  elevation: 24,
                                ));
                      } else {
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text('Something went wrong!!'),
                        ));
                      }
                    }
                  },
                ),

                SignInButton(
                  Buttons.Google,
                  onPressed: () async {
                    dynamic googleSignIn = await _authService.signInGoogle();
                  },
                ),
                SignInButtonBuilder(
                  text: 'Try anonymously',
                  icon: Icons.person,
                  backgroundColor: Colors.black,
                  onPressed: () async {
                    dynamic anon = await _authService.signInAnon();
                  },
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}

// Counter widget
Widget counter(
  BuildContext context, {
  int currentLength,
  int minLength,
  int maxLength,
}) {
  if (currentLength > minLength && currentLength < maxLength ||
      currentLength == 0) {
    return Text(
      '$currentLength of $maxLength characters',
      semanticsLabel: 'character count',
      style: TextStyle(
        fontSize: 10,
        color: Colors.black,
      ),
    );
  } else {
    return Text(
      '$currentLength of $maxLength characters',
      semanticsLabel: 'character count',
      style: TextStyle(
        fontSize: 10,
        color: Colors.red,
      ),
    );
  }
}
