// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:my_discord/models/chat_message.dart';

// class ChatService {
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   String getChatRoomId(String userId1, String userId2) {
//     final ids = [userId1, userId2]..sort();
//     return ids.join('_');
//   }

//   Future<void> sendMessage({
//     required String receiverId,
//     required String messageText,
//     String? audioUrl,
//     bool isVoiceMessage = false,
//   }) async {
//     final String currentUserId = _firebaseAuth.currentUser!.uid;
//     final String currentUserEmail = _firebaseAuth.currentUser!.email ?? '';
//     final String chatRoomId = getChatRoomId(currentUserId, receiverId);
//     final now = Timestamp.now();

//     final messageData = {
//       'receiverID': receiverId,
//       'senderEmail': currentUserEmail,
//       'senderId': currentUserId,
//       'timestamp': now,
//       'message': messageText,
//       'isRead': 0,
//       'audioUrl': audioUrl,
//       'isVoiceMessage': isVoiceMessage,
//     };

//     // Firebase Update
//     await _firestore
//         .collection('chat_rooms')
//         .doc(chatRoomId)
//         .collection('messages')
//         .add(messageData);

//     await _firestore.collection('chat_rooms').doc(chatRoomId).set({
//       'participants': [currentUserId, receiverId],
//       'lastMessage': messageText,
//       'lastMessageTime': now,
//     }, SetOptions(merge: true));
//   }

//   Stream<List<ChatMessage>> getChatRooms(String currentUserId) {
//     return _firestore
//         .collection('chat_rooms')
//         .where('participants', arrayContains: currentUserId)
//         .orderBy('lastMessageTime', descending: true)
//         .snapshots()
//         .asyncMap((snapshot) async {
//       List<ChatRoom> rooms = [];
//       for (var doc in snapshot.docs) {
//         final data = doc.data();
//         final List participants = data['participants'] ?? [];
//         final String otherUserId = participants
//             .firstWhere((id) => id != currentUserId, orElse: () => '');

//         String otherUserName = "User";
//         final userDoc =
//             await _firestore.collection('Users').doc(otherUserId).get();
//         if (userDoc.exists) {
//           otherUserName = userDoc.data()?['username'] ?? "No Name";
//         }

//         rooms.add(ChatRoom(
//           participant1Id: participants[0],
//           participant2Id: participants.length > 1 ? participants[1] : '',
//           otherUserName: otherUserName,
//           lastMessage: data['lastMessage'] ?? '',
//           lastMessageTime: (data['lastMessageTime'] as Timestamp?)?.toDate(),
//         ));
//       }
//       return rooms;
//     });
//   }
// }

 