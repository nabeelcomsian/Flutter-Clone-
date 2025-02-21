import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram/Models/User_Model.dart' as model;

class AuthMethod {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<String> signUpUser({
    required String userName,
    required String bio,
    required String email,
    required String password,
    // Uint8List file,
  }) async {
    String res = 'some error occured';
    try {
      if (userName.isNotEmpty ||
          bio.isNotEmpty ||
          email.isNotEmpty ||
          password.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        // adding to data base
        model.UserModel user = model.UserModel(
            userName: userName,
            bio: bio,
            email: email,
            followers: [],
            following: [],
            uid: cred.user!.uid);

        await _firestore
            .collection('Users')
            .doc(cred.user!.uid)
            .set(user.toJason());
        return res = 'succcess';
      }
    } catch (err) {
      debugPrint('empty signup it hit');
      res = err.toString();
    }
    return res;
  }
}
