import 'package:flutter/material.dart';
import 'package:fluttertodoapplication/models/task.dart';
import 'package:fluttertodoapplication/models/user.dart';
import 'package:fluttertodoapplication/screens/home/task_list.dart';
import 'package:fluttertodoapplication/services/auth.dart';
import 'package:fluttertodoapplication/services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamProvider<List<Task>>.value(
      value: DatabaseService(uid: user.uid).tasks,
      child: Scaffold(
        appBar: AppBar(
          title: Text('TO-DO My Dream'),
          backgroundColor: Colors.blue,
          actions: <Widget>[
            FlatButton.icon(
                onPressed: () async {
                  await _authService.signOut();
                },
                icon: Icon(Icons.exit_to_app),
                label: Text('Logout'))
          ],
        ),
        body: Container(child: TaskList()),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async{
            await DatabaseService(uid: user.uid).addTask('Added', 'New Task', Colors.red);
          },
        ),
      ),
    );
  }
}
