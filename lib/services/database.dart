import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference taskCollection =
      Firestore.instance.collection('users');

  Future updateUserData(String name) async {
    return await taskCollection.document(uid).setData({'name': name});
  }
}
