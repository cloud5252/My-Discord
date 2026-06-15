import 'package:hive_ce/hive.dart';

part 'hive_user_model.g.dart';

@HiveType(typeId: 0)
class HiveUserModel {
  @HiveField(0)
  final String uid;

  @HiveField(1)
  final String username;

  @HiveField(2)
  final String displayName;

  @HiveField(3)
  final String email;

  @HiveField(4)
  final DateTime createdAt;

  @HiveField(5)
  final String status;

  HiveUserModel({
    required this.uid,
    required this.username,
    required this.displayName,
    required this.email,
    required this.createdAt,
    required this.status,
  });

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
