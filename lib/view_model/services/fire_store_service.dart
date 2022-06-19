import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app/models/user_model.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class Firestore {
  final CollectionReference _users =
      FirebaseFirestore.instance.collection('users');

  Future<void> addUserToFirestore(UserModel userModel) async {
    return await _users.doc(userModel.id).set(userModel.toJson());
  }

  Future<DocumentSnapshot<Object?>> getUserFromFireStore(String uid) async {
    return await _users.doc(uid).get();
  }

  Future<void> updateUser({required String uId, required Map<String, dynamic> userData}) {
    return _users
        .doc(uId)
        .update(userData)
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }
}
