import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String? chatRoomId;
  final String? senderId;
  final String? senderEmail;
  final String? receiverId;
  final String? messageText;
  final Timestamp? timestamp;
  final int? isRead;
  final bool? isVoiceMessage;
  final String? profileUrl;

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
  });

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      chatRoomId: map['chatRoomId'],
      senderId: map['senderId'],
      senderEmail: map['senderEmail'],
      receiverId: map['receiverId'], // ← lowercase d
      messageText: map['messageText'], // ← messageText
      timestamp: map['timestamp'],
      isRead: map['isRead'],
      isVoiceMessage: map['isVoiceMessage'],
      profileUrl: map['profileUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'chatRoomId': chatRoomId,
      'senderId': senderId,
      'senderEmail': senderEmail,
      'receiverId': receiverId,
      'messageText': messageText,
      'timestamp': timestamp,
      'isRead': isRead,
      'isVoiceMessage': isVoiceMessage,
      'profileUrl': profileUrl,
    };
  }
}
