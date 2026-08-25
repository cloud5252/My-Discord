import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:my_discord/app/app.locator.dart';
import 'package:my_discord/models/messsage_model.dart';
import 'package:my_discord/service/FB_Auth/registration_auth.dart';
import 'package:uuid/uuid.dart';

class ChatService {
  final _firestore = FirebaseFirestore.instance;
  final _auth = locator<registrationAuth>();

  final Map<String, StreamController<List<MessageModel>>> _controllers = {};
  final Map<String, List<MessageModel>> _lastEmitted = {};

  StreamController<List<MessageModel>> _getController(String chatRoomId) {
    if (!_controllers.containsKey(chatRoomId)) {
      _controllers[chatRoomId] =
          StreamController<List<MessageModel>>.broadcast();

      _firestore
          .collection('chat_rooms')
          .doc(chatRoomId)
          .collection('messages')
          .orderBy('timestamp', descending: false)
          .snapshots()
          .listen((snap) {
        final messages =
            snap.docs.map((doc) => MessageModel.fromMap(doc.data())).toList();

        _lastEmitted[chatRoomId] = messages;
        _controllers[chatRoomId]?.add(messages);
      });
    }
    return _controllers[chatRoomId]!;
  }

  Stream<List<MessageModel>> getMessages(String receiverId) {
    final myUid = _auth.getCurrentuser()!.uid;
    final chatRoomId = getChatRoomId(myUid, receiverId);

    _getController(chatRoomId);

    return Stream<List<MessageModel>>.multi((controller) {
      if (_lastEmitted.containsKey(chatRoomId)) {
        controller.add(_lastEmitted[chatRoomId]!);
      }
      _controllers[chatRoomId]!.stream.listen(
            controller.add,
            onError: controller.addError,
            onDone: controller.close,
          );
    });
  }

  Future<void> sendMessage({
    required String receiverId,
    required String messageText,
    String? replyToMessageId,
    String? replyToText,
    String? replyToSender,
  }) async {
    final myUid = _auth.getCurrentuser()!.uid;
    final myEmail = _auth.getCurrentuser()!.email ?? '';
    final chatRoomId = getChatRoomId(myUid, receiverId);
    final id = const Uuid().v4();
    final now = DateTime.now();

    try {
      await _firestore
          .collection('chat_rooms')
          .doc(chatRoomId)
          .collection('messages')
          .doc(id)
          .set({
        'firebaseId': id,
        'chatRoomId': chatRoomId,
        'senderId': myUid,
        'senderEmail': myEmail,
        'receiverId': receiverId,
        'messageText': messageText,
        'timestamp': Timestamp.fromDate(now),
        'isRead': 0,
        'isVoiceMessage': false,
        'profileUrl': '',
        'replyToMessageId': replyToMessageId,
        'replyToText': replyToText,
        'replyToSender': replyToSender,
      });

      await _firestore.collection('chat_rooms').doc(chatRoomId).set({
        'participants': [myUid, receiverId],
        'lastMessage': messageText,
        'lastMessageTime': Timestamp.fromDate(now),
      }, SetOptions(merge: true));
    } catch (e) {
      print('❌ Send error: $e');
    }
  }

  void disposeRoom(String chatRoomId) {
    _controllers[chatRoomId]?.close();
    _controllers.remove(chatRoomId);
    _lastEmitted.remove(chatRoomId);
  }

  Future<void> deleteMessage(MessageModel message) async {
    try {
      await _firestore
          .collection('chat_rooms')
          .doc(message.chatRoomId)
          .collection('messages')
          .doc(message.firebaseId)
          .delete();

      print("✅ Deleted successfully");
    } catch (e) {
      print("❌ Error: $e");
    }
  }

  Future<void> editMessage({
    required MessageModel message,
    required String newText,
  }) async {
    try {
      await _firestore
          .collection('chat_rooms')
          .doc(message.chatRoomId)
          .collection('messages')
          .doc(message.firebaseId)
          .update({
        'messageText': newText,
        'isEdited': true,
      });

      print("✅ Edited successfully");
    } catch (e) {
      print("❌ Edit error: $e");
    }
  }

  void syncReactionToFirestore({
    required MessageModel message,
    required Map<String, List<String>> reactions,
  }) {
    _firestore
        .collection('chat_rooms')
        .doc(message.chatRoomId)
        .collection('messages')
        .doc(message.firebaseId)
        .set({'reactions': reactions}, SetOptions(merge: true)).catchError((e) {
      debugPrint('⚠️ Firestore reaction sync failed: $e');
    });
  }

  void syncPinToFirestore({
    required MessageModel message,
    required bool isPinned,
  }) {
    _firestore
        .collection('chat_rooms')
        .doc(message.chatRoomId)
        .collection('messages')
        .doc(message.firebaseId)
        .set({'isPinned': isPinned}, SetOptions(merge: true)).catchError((e) {
      debugPrint('⚠️ Firestore pin sync failed: $e');
    });
  }
}

String getChatRoomId(String uid1, String uid2) {
  final sorted = [uid1, uid2]..sort();
  return '${sorted[0]}_${sorted[1]}';
}
