import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_discord/models/user_model.dart';

class Authentication {
  static final Authentication _instance = Authentication._internal();
  factory Authentication() => _instance;
  Authentication._internal();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  String? get currentUsers => _firebaseAuth.currentUser?.email;

  User? getCurrentuser() {
    return _firebaseAuth.currentUser;
  }

  Future<UserCredential> signIn(String email, String password) async {
    try {
      UserCredential? userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<UserCredential?> createdAccount(
      String name, String email, String password, String displayname) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      final firebaseUser = userCredential.user;

      if (firebaseUser == null) {
        throw Exception("User creation failed on Firebase");
      }

      UserModel newUser = UserModel(
        uid: firebaseUser.uid,
        username: name,
        displayName: displayname,
        email: email,
        createdAt: DateTime.now(),
        status: 'online',
      );

      await _firestore
          .collection('Users')
          .doc(firebaseUser.uid)
          .set(newUser.toMap());

      return userCredential;
    } on FirebaseAuthException catch (e) {
      debugPrint("Firebase Auth Error: ${e.code} - ${e.message}");
      rethrow;
    } catch (e) {
      debugPrint("General Error: $e");
      return null;
    }
  }

  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }
}
