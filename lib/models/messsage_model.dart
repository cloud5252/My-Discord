import 'dart:convert';

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
  String? messageText;

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

  @HiveField(11)
  bool? isEdited;
  @HiveField(12)
  String? replyToMessageId;

  @HiveField(13)
  String? replyToText;

  @HiveField(14)
  String? replyToSender;
  @HiveField(15)
  String? reactionsJson;
  @HiveField(16)
  bool? isPinned;
  Map<String, List<String>> get reactions {
    if (reactionsJson == null || reactionsJson!.isEmpty) return {};
    final decoded = jsonDecode(reactionsJson!) as Map<String, dynamic>;
    return decoded.map(
      (key, value) => MapEntry(key, List<String>.from(value)),
    );
  }

  set reactions(Map<String, List<String>> value) {
    reactionsJson = jsonEncode(value);
  }

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
    required this.replyToMessageId,
    required this.replyToText,
    required this.replyToSender,
    this.firebaseId,
    this.isPending = false,
    this.isEdited = false,
    this.isPinned = false,
  });

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    final message = MessageModel(
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
      isEdited: map['isEdited'] ?? false,
      replyToMessageId: map['replyToMessageId'],
      replyToText: map['replyToText'],
      replyToSender: map['replyToSender'],
      isPinned: map['isPinned'] ?? false,
    );

    final rawReactions = map['reactions'] as Map<String, dynamic>? ?? {};
    message.reactions = rawReactions.map(
      (key, value) => MapEntry(key, List<String>.from(value)),
    );

    return message;
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
      'isEdited': isEdited,
      'replyToMessageId': replyToMessageId,
      'replyToText': replyToText,
      'replyToSender': replyToSender,
      'reactions': reactions,
      'isPinned': isPinned,
    };
  }
}
