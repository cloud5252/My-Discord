import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_discord/app/app.locator.dart';
import 'package:my_discord/models/messsage_model.dart';
import 'package:my_discord/service/FB_Auth/Authentication.dart';

class ChatService {
  final _firestore = FirebaseFirestore.instance;
  final _auth = locator<Authentication>();

  String getChatRoomId(String uid1, String uid2) {
    final sorted = [uid1, uid2]..sort();
    return '${sorted[0]}_${sorted[1]}';
  }

  Future<void> sendMessage({
    required String receiverId,
    required String messageText,
  }) async {
    final myUid = _auth.getCurrentuser()!.uid;
    final myEmail = _auth.getCurrentuser()!.email ?? '';
    final chatRoomId = getChatRoomId(myUid, receiverId);
    final now = Timestamp.now();

    final docRef = _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .doc();

    await docRef.set({
      'firebaseId': docRef.id,
      'chatRoomId': chatRoomId,
      'senderId': myUid,
      'senderEmail': myEmail,
      'receiverId': receiverId,
      'messageText': messageText,
      'timestamp': now,
      'isRead': 0,
      'isVoiceMessage': false,
      'profileUrl': '',
    });

    await _firestore.collection('chat_rooms').doc(chatRoomId).set({
      'participants': [myUid, receiverId],
      'lastMessage': messageText,
      'lastMessageTime': now,
    }, SetOptions(merge: true));
  }

  Stream<List<MessageModel>> getMessages(String receiverId) {
    final myUid = _auth.getCurrentuser()!.uid;
    final chatRoomId = getChatRoomId(myUid, receiverId);

    print('chatRoomId: $chatRoomId');

    return _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots()
        .map((snap) =>
            snap.docs.map((d) => MessageModel.fromMap(d.data())).toList());
  }
}
