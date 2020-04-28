import 'package:flutter/material.dart';
import 'package:fluttertodoapplication/models/task.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  TaskTile({this.task});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: task.color,
            radius: 20,
          ),
          title: Text(task.title),
          subtitle: Text(task.subtitle),
          enabled: !task.isComplited,
        ),
      ),
    );
  }
}
