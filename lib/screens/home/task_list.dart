import 'package:flutter/material.dart';
import 'package:fluttertodoapplication/models/task.dart';
import 'package:fluttertodoapplication/models/user.dart';
import 'package:fluttertodoapplication/screens/home/task_tile.dart';
import 'package:fluttertodoapplication/services/database.dart';
import 'package:provider/provider.dart';

class TaskList extends StatefulWidget {
  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    final tasks = Provider.of<List<Task>>(context) ?? [];
    final user = Provider.of<User>(context);
    final DatabaseService _databaseService = DatabaseService(uid: user.uid);
    print(tasks);
    return ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return Dismissible(
              key: Key(tasks[index].toString()),
              child: TaskTile(task: tasks[index]),
              background: Container(color: Colors.red),
              onDismissed: (direction) {
                //TODO add bidirectional interaction. To left - completed, to right removing
                setState(() {
                  final date = tasks[index].date;
//                  print(tasks[index]);
                  //TODO add removing in database
                  tasks.removeAt(index);
                  _databaseService.removeTask(date);
                });
              });
        });
  }
}
