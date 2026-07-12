import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_ce/hive.dart';
import 'package:my_discord/app/app.locator.dart';
import 'package:my_discord/models/messsage_model.dart';
import 'package:my_discord/service/FB_Auth/Authentication.dart';
import 'package:uuid/uuid.dart';

class ChatService {
  final _firestore = FirebaseFirestore.instance;
  final _auth = locator<Authentication>();
  late final Box<MessageModel> _box;

  final Map<String, StreamController<List<MessageModel>>> _controllers = {};

  ChatService() {
    _box = Hive.box<MessageModel>('messages_box');
  }

  StreamController<List<MessageModel>> _getController(String chatRoomId) {
    if (!_controllers.containsKey(chatRoomId)) {
      _controllers[chatRoomId] =
          StreamController<List<MessageModel>>.broadcast();

      Future.delayed(Duration.zero, () => emitMessages(chatRoomId));

      _firestore
          .collection('chat_rooms')
          .doc(chatRoomId)
          .collection('messages')
          .orderBy('timestamp', descending: false)
          .snapshots()
          .listen((snap) {
        // ↓ YAHAN CHANGE HAI — docChanges use kar rahe hain
        for (final change in snap.docChanges) {
          final data = change.doc.data();
          if (data == null) continue;

          final msg = MessageModel.fromMap(data);

          // Naya message aaya
          if (change.type == DocumentChangeType.added) {
            if (_box.containsKey(msg.firebaseId)) {
              // Pehle se hai — sirf isPending update karo
              final existing = _box.get(msg.firebaseId)!;
              if (existing.isPending == true) {
                existing.isPending = false;
                existing.save();
              }
            } else {
              // Bilkul naya — Hive mein daalo
              _box.put(msg.firebaseId, msg);
            }
          }

          // Message edit/update hua
          else if (change.type == DocumentChangeType.modified) {
            _box.put(msg.firebaseId, msg);
          }

          // Message delete hua ← YE NAYA HAI
          else if (change.type == DocumentChangeType.removed) {
            _box.delete(msg.firebaseId); // Hive se bhi hatao ✅
          }
        }

        emitMessages(chatRoomId);
      });
    }
    return _controllers[chatRoomId]!;
  }

  final Map<String, List<MessageModel>> _lastEmitted = {};

  void emitMessages(String chatRoomId) {
    final messages = _box.values
        .where((m) => m.chatRoomId == chatRoomId)
        .toList()
      ..sort((a, b) => a.timestamp!.compareTo(b.timestamp ?? DateTime.now()));

    _lastEmitted[chatRoomId] = messages;
    _controllers[chatRoomId]?.add(messages);
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

    final message = MessageModel(
      firebaseId: id,
      chatRoomId: chatRoomId,
      senderId: myUid,
      senderEmail: myEmail,
      receiverId: receiverId,
      messageText: messageText,
      timestamp: now,
      isRead: 0,
      isVoiceMessage: false,
      profileUrl: '',
      isPending: true,
      replyToMessageId: replyToMessageId,
      replyToText: replyToText,
      replyToSender: replyToSender,
    );

    await _box.put(id, message);
    emitMessages(chatRoomId);

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
        'replyToMessageId': replyToMessageId, // ← naya
        'replyToText': replyToText, // ← naya
        'replyToSender': replyToSender,
      });

      await _firestore.collection('chat_rooms').doc(chatRoomId).set({
        'participants': [myUid, receiverId],
        'lastMessage': messageText,
        'lastMessageTime': Timestamp.fromDate(now),
      }, SetOptions(merge: true));

      message.isPending = false;
      await message.save();
      emitMessages(chatRoomId);
    } catch (e) {
      print('❌ Send error: $e');
    }
  }

  void disposeRoom(String chatRoomId) {
    _controllers[chatRoomId]?.close();
    _controllers.remove(chatRoomId);
  }

  Future<void> deleteMessage(MessageModel message) async {
    try {
      // Firebase se delete
      await _firestore
          .collection('chat_rooms')
          .doc(message.chatRoomId)
          .collection('messages')
          .doc(message.firebaseId)
          .delete();

      // Hive se bhi delete — docChanges bhi karega
      // lekin ye instant UI update ke liye
      await _box.delete(message.firebaseId);
      emitMessages(message.chatRoomId!);

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
      // Firebase update
      await _firestore
          .collection('chat_rooms')
          .doc(message.chatRoomId)
          .collection('messages')
          .doc(message.firebaseId)
          .update({
        'messageText': newText,
        'isEdited': true,
      });

      // Instant UI update — docChanges bhi karega
      // lekin ye turant dikhaye
      message.messageText = newText;
      message.isEdited = true;
      await message.save();
      emitMessages(message.chatRoomId!);

      print("✅ Edited successfully");
    } catch (e) {
      print("❌ Edit error: $e");
    }
  }

  void syncReactionToFirestore({
    required MessageModel message,
    required Map<String, List<String>> reactions,
  }) {
    // Note: 'await' nahi lagaya, ye fire-and-forget hai
    FirebaseFirestore.instance
        .collection('chat_rooms')
        .doc(message.chatRoomId)
        .collection('messages')
        .doc(message.firebaseId)
        .set({'reactions': reactions}, SetOptions(merge: true)).catchError((e) {
      debugPrint('⚠️ Firestore reaction sync failed: $e');
      // Yahan chahen to retry-logic ya error-snackbar bhi laga sakte hain
    });
  }

  void syncPinToFirestore({
    required MessageModel message,
    required bool isPinned,
  }) {
    FirebaseFirestore.instance
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
