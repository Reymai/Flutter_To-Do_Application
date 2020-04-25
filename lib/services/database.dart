import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference userCollection =
      Firestore.instance.collection('users');

  Future updateUserData(String name) async {
    return await userCollection.document(uid).setData({'name': name});
  }

  Future addTask(String title, String subtitle, Color color) async {
    final CollectionReference taskCollection = userCollection
        .document(uid)
        .collection('Tasks');
    return await taskCollection.document().setData({
      'complited': false,
      'title': title,
      'subtitle': subtitle,
      'color': color.toString().substring(35,
          45) // MaterialColor(primary value: Color(0xffcddc39)) = 0xffcddc39
    });
  }
}
