class UserModel {
  final String uid;
  final String username;
  final String displayName;
  final String email;
  final String? photoUrl;
  final String status;
  final DateTime createdAt;

  UserModel({
    required this.uid,
    required this.username,
    required this.displayName,
    required this.email,
    this.photoUrl,
    this.status = 'offline',
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': username,
      'displayName': displayName,
      'email': email,
      'photoUrl': photoUrl ?? '',
      'status': status,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // Firebase se data nikalne ke liye
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      username: map['username'] ?? '',
      displayName: map['displayName'] ?? '',
      email: map['email'] ?? '',
      photoUrl: map['photoUrl'],
      status: map['status'] ?? 'offline',
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}
