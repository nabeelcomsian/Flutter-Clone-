import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

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
        await _firestore.collection('Users').doc(cred.user!.uid).set({
          'name': userName,
          'uid': cred.user!.uid,
          'bio': bio,
          'folowers': [],
          'following': [],
        });
        return res = 'succcess';
      }
    } catch (err) {
      debugPrint('empty signup it hit');
      res = err.toString();
    }
    return res;
  }
}
