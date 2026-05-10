// ignore_for_file: unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_discord/models/contect_model.dart';
import 'package:my_discord/models/user_model.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<UserModel> _allFriends = [];
  Future<List<UserModel>> getAllUsers() async {
    try {
      var snapshot = await _firestore.collection('Users').get();
      return snapshot.docs.map((doc) => UserModel.fromMap(doc.data())).toList();
    } catch (e) {
      print("Error fetching users: $e");
      return [];
    }
  }

  Future<UserModel?> getUserById(String uid) async {
    try {
      var doc = await _firestore.collection('Users').doc(uid).get();
      if (doc.exists) {
        return UserModel.fromMap(doc.data()!);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Stream<List<ContactModel>> getMyFriends(String currentUserId) {
    return _firestore
        .collection('Users')
        .doc(currentUserId)
        .collection('friends')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => ContactModel.fromMap(doc.data()))
          .toList();
    });
  }

  Future<void> addToContacts(String currentUserId, UserModel user) async {
    ContactModel newContact = ContactModel(
      uid: user.uid,
      displayName: user.displayName,
      email: user.email,
      photoUrl: user.photoUrl,
      status: user.status,
      contactStatus: 'friend',
      addedAt: DateTime.now(),
    );

    await _firestore
        .collection('Users')
        .doc(currentUserId)
        .collection('contacts')
        .doc(user.uid)
        .set(newContact.toMap());
  }

  void listenToFriends() {
    final myUid = _auth.currentUser!.uid;

    _firestore
        .collection('Contacts')
        .where('ownerId', isEqualTo: myUid)
        .snapshots()
        .listen((snapshot) {
      if (snapshot.docs.isEmpty) {
        _allFriends = [];

        return;
      }
    });
  }
}
