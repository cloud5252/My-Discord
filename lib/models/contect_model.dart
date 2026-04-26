import 'package:cloud_firestore/cloud_firestore.dart';

class ContactModel {
  final String uid;
  final String displayName;
  final String email;
  final String? photoUrl;
  final String status;
  final String contactStatus;
  final DateTime addedAt;

  ContactModel({
    required this.uid,
    required this.displayName,
    required this.email,
    this.photoUrl,
    required this.status,
    this.contactStatus = 'friend',
    required this.addedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'displayName': displayName,
      'email': email,
      'photoUrl': photoUrl ?? '',
      'status': status,
      'contactStatus': contactStatus,
      'addedAt': Timestamp.fromDate(addedAt),
    };
  }

  factory ContactModel.fromMap(Map<String, dynamic> map) {
    return ContactModel(
      uid: map['uid'] ?? '',
      displayName: map['displayName'] ?? '',
      email: map['email'] ?? '',
      photoUrl: map['photoUrl'],
      status: map['status'] ?? 'offline',
      contactStatus: map['contactStatus'] ?? 'friend',
      addedAt: (map['addedAt'] as Timestamp).toDate(),
    );
  }
}
