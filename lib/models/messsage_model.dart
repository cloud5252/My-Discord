import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String? chatRoomId;
  final String? senderId;
  final String? senderEmail;
  final String? receiverId;
  String? messageText;
  final DateTime? timestamp;
  final int? isRead;
  final bool? isVoiceMessage;
  final String? profileUrl;
  final String? firebaseId;
  bool? isPending;
  bool? isEdited;
  String? replyToMessageId;
  String? replyToText;
  String? replyToSender;
  Map<String, List<String>> reactions;
  bool? isPinned;

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
    Map<String, List<String>>? reactions,
  }) : reactions = reactions ?? {};

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    final rawReactions = map['reactions'] as Map<String, dynamic>? ?? {};

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
      isEdited: map['isEdited'] ?? false,
      replyToMessageId: map['replyToMessageId'],
      replyToText: map['replyToText'],
      replyToSender: map['replyToSender'],
      isPinned: map['isPinned'] ?? false,
      reactions: rawReactions.map(
        (key, value) => MapEntry(key, List<String>.from(value)),
      ),
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
      'isEdited': isEdited,
      'replyToMessageId': replyToMessageId,
      'replyToText': replyToText,
      'replyToSender': replyToSender,
      'reactions': reactions,
      'isPinned': isPinned,
    };
  }
}
