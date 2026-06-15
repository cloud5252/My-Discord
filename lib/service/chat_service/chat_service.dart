import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  // Per chatRoom ek controller
  StreamController<List<MessageModel>> _getController(String chatRoomId) {
    if (!_controllers.containsKey(chatRoomId)) {
      _controllers[chatRoomId] =
          StreamController<List<MessageModel>>.broadcast();

      // broadcast stream subscribe hone ka wait karo
      Future.delayed(Duration.zero, () => _emitMessages(chatRoomId)); // ✅

      _firestore
          .collection('chat_rooms')
          .doc(chatRoomId)
          .collection('messages')
          .orderBy('timestamp', descending: false)
          .snapshots()
          .listen((snap) {
        for (final doc in snap.docs) {
          final msg = MessageModel.fromMap(doc.data());
          if (_box.containsKey(msg.firebaseId)) {
            final existing = _box.get(msg.firebaseId)!;
            if (existing.isPending == true) {
              existing.isPending = false;
              existing.save();
            }
          } else {
            _box.put(msg.firebaseId, msg);
          }
        }
        _emitMessages(chatRoomId);
      });
    }
    return _controllers[chatRoomId]!;
  }

  // chat_service.dart mein ye add karo
  final Map<String, List<MessageModel>> _lastEmitted = {};

  void _emitMessages(String chatRoomId) {
    final messages = _box.values
        .where((m) => m.chatRoomId == chatRoomId)
        .toList()
      ..sort((a, b) => a.timestamp!.compareTo(b.timestamp ?? DateTime.now()));

    _lastEmitted[chatRoomId] = messages; // cache karo
    _controllers[chatRoomId]?.add(messages);
  }

  Stream<List<MessageModel>> getMessages(String receiverId) {
    final myUid = _auth.getCurrentuser()!.uid;
    final chatRoomId = getChatRoomId(myUid, receiverId);

    _getController(chatRoomId);

    // Last cached value + new updates
    return Stream<List<MessageModel>>.multi((controller) {
      // Turant last value do
      if (_lastEmitted.containsKey(chatRoomId)) {
        controller.add(_lastEmitted[chatRoomId]!);
      }
      // Phir live stream se updates do
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
    );

    // 1. Hive mein save + stream update (grey)
    await _box.put(id, message);
    _emitMessages(chatRoomId);

    // 2. Firestore background upload
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
      });

      await _firestore.collection('chat_rooms').doc(chatRoomId).set({
        'participants': [myUid, receiverId],
        'lastMessage': messageText,
        'lastMessageTime': Timestamp.fromDate(now),
      }, SetOptions(merge: true));

      // 3. Firestore done — isPending false (white)
      // Note: Firestore listener khud handle kar lega via snapshots()
      // lekin agar turant chahiye:
      message.isPending = false;
      await message.save();
      _emitMessages(chatRoomId);
    } catch (e) {
      // Failed — pending hi rehne do ya error state add karo
    }
  }

  void disposeRoom(String chatRoomId) {
    _controllers[chatRoomId]?.close();
    _controllers.remove(chatRoomId);
  }
}

String getChatRoomId(String uid1, String uid2) {
  final sorted = [uid1, uid2]..sort();
  return '${sorted[0]}_${sorted[1]}';
}
