import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertodoapplication/models/task.dart';
import 'dart:math';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference userCollection =
      Firestore.instance.collection('users');

  Future<String> getUserUid() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    print(user.uid);
    return user.uid;
  }

  Future updateUserData(String name) async {
    return await userCollection.document(uid).setData({'name': name});
  }

  Future addTask(String title, String subtitle, Color color) async {
    final CollectionReference taskCollection = Firestore.instance
        .collection('users')
        .document(uid)
        .collection('Tasks');
    return await taskCollection.document().setData({
      'complited': false,
      'date':
          (DateTime.now().millisecondsSinceEpoch / 1000).round(), // unix time
      'title': title,
      'subtitle': subtitle,
      'color': color
          .value // MaterialColor(primary value: Color(0xffcddc39)) = 0xffcddc39
    });
  }

  Future removeTask(date) {
    //TODO add remove task feature
  }

  //task list from snapshot
  List<Task> _taskListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Task(
          color: Color(doc.data['color']) ?? Colors.white,
          isComplited: doc.data['complited'] ?? false,
          date: doc.data['date'] ?? 0,
          subtitle: doc.data["subtitle"] ?? '',
          title: doc.data["title"] ?? "");
    }).toList();
  }

  //get tasks streams
  Stream<List<Task>> get tasks {
//    final uid = getUserUid().toString();
    print(uid);
    return userCollection
        .document(uid)
        .collection('Tasks')
        .orderBy('date', descending: true)
        .snapshots()
        .map(_taskListFromSnapshot);
  }
}
