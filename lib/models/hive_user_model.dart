class HiveUserModel {
  final String uid;
  final String username;
  final String displayName;
  final String email;
  final DateTime createdAt;
  final String status;

  HiveUserModel({
    required this.uid,
    required this.username,
    required this.displayName,
    required this.email,
    required this.createdAt,
    required this.status,
  });

  factory HiveUserModel.fromMap(Map<String, dynamic> map) {
    return HiveUserModel(
      uid: map['uid'] ?? '',
      username: map['username'] ?? '',
      displayName: map['displayName'] ?? '',
      email: map['email'] ?? '',
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'])
          : DateTime.now(),
      status: map['status'] ?? 'offline',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': username,
      'displayName': displayName,
      'email': email,
      'createdAt': createdAt.toIso8601String(),
      'status': status,
    };
  }
}
