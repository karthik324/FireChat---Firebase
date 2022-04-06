// import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/foundation.dart';

Future<User?> createAccount(String name, String email, String password) async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  User? user;
  try {
    user = (await _auth.createUserWithEmailAndPassword(
            email: email, password: password))
        .user;

    if (user != null) {
      print('acc created');
      await _fireStore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .set({"name": name, "email": email, "status": "unavailable"});
      return user;
    } else {
      print('failed');
      return user;
    }
  } catch (e) {
    print(e);
  }
  return user;
}

Future<User?> logIn(String email, String password) async {
  FirebaseAuth _auth = FirebaseAuth.instance;

  User? user;
  try {
    user = (await _auth.signInWithEmailAndPassword(
            email: email, password: password))
        .user;
    if (user != null) {
      print('success');
      return user;
    } else {
      print('failed');
      return user;
    }
  } catch (e) {
    print(e);
  }
  return user;
}

Future logOut() async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  try {
    await _auth.signOut();
  } catch (e) {
    print(e);
  }
}
