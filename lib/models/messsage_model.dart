import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_ce/hive.dart';

part 'messsage_model.g.dart';

@HiveType(typeId: 1)
class MessageModel extends HiveObject {
  @HiveField(0)
  final String? chatRoomId;

  @HiveField(1)
  final String? senderId;

  @HiveField(2)
  final String? senderEmail;

  @HiveField(3)
  final String? receiverId;

  @HiveField(4)
  final String? messageText;

  @HiveField(5)
  final DateTime? timestamp;

  @HiveField(6)
  final int? isRead;

  @HiveField(7)
  final bool? isVoiceMessage;

  @HiveField(8)
  final String? profileUrl;

  @HiveField(9)
  final String? firebaseId;

  @HiveField(10)
  bool? isPending;

  MessageModel({
    required this.chatRoomId,
    required this.senderId,
    required this.senderEmail,
    required this.receiverId,
    required this.messageText,
    required this.timestamp,
    required this.isRead,
    required this.isVoiceMessage,
    required this.profileUrl,
    this.firebaseId,
    this.isPending = false,
  });

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      chatRoomId: map['chatRoomId'],
      senderId: map['senderId'],
      senderEmail: map['senderEmail'],
      receiverId: map['receiverId'],
      messageText: map['messageText'],
      timestamp: (map['timestamp'] as Timestamp?)?.toDate(),
      isRead: map['isRead'],
      isVoiceMessage: map['isVoiceMessage'],
      profileUrl: map['profileUrl'],
      firebaseId: map['firebaseId'],
      isPending: map['isPending'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'chatRoomId': chatRoomId,
      'senderId': senderId,
      'senderEmail': senderEmail,
      'receiverId': receiverId,
      'messageText': messageText,
      'timestamp': timestamp != null ? Timestamp.fromDate(timestamp!) : null,
      'isRead': isRead,
      'isVoiceMessage': isVoiceMessage,
      'profileUrl': profileUrl,
      'isPending': isPending,
    };
  }
}
