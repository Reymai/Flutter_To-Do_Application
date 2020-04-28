import 'package:flutter/material.dart';
import 'package:fluttertodoapplication/models/task.dart';
import 'package:fluttertodoapplication/screens/home/task_tile.dart';
import 'package:provider/provider.dart';

class TaskList extends StatefulWidget {
  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    final tasks = Provider.of<List<Task>>(context) ?? [];
    print(tasks);
    return ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return TaskTile(task: tasks[index]);
        });
  }
}
