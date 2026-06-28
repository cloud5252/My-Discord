import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_discord/app/app.locator.dart';
import 'package:my_discord/service/FB_Auth/Authentication.dart';
import 'package:stacked/stacked.dart';

class AddFraindViewModel extends BaseViewModel {
  final _auth = locator<Authentication>();
  final _firestore = FirebaseFirestore.instance;
  final textController = TextEditingController();

  String inputValue = '';
  String? feedbackMessage;
  bool isSuccess = false;

  void onInputChanged(String value) {
    inputValue = value;
    feedbackMessage = null;
    notifyListeners();
  }

  Future<void> sendFriendRequest() async {
    if (isBusy) return;
    setBusy(true);
    feedbackMessage = null;

    try {
      final myUid = _auth.getCurrentuser()?.uid;
      if (myUid == null) return;

      final query = await _firestore
          .collection('Users')
          .where('username', isEqualTo: inputValue.trim())
          .limit(1)
          .get();

      if (query.docs.isEmpty) {
        feedbackMessage =
            'Hm, didn\'t work. Check that the username is correct.';
        isSuccess = false;
        setBusy(false);
        notifyListeners();
        return;
      }

      final targetUser = query.docs.first;
      final targetUid = targetUser.id;

      if (targetUid == myUid) {
        feedbackMessage = 'You cannot send a request to yourself.';
        isSuccess = false;
        setBusy(false);
        notifyListeners();
        return;
      }

      final existing = await _firestore
          .collection('friend_requests')
          .where('fromUid', isEqualTo: myUid)
          .where('toUid', isEqualTo: targetUid)
          .where('status', isEqualTo: 'pending')
          .limit(1)
          .get();

      if (existing.docs.isNotEmpty) {
        feedbackMessage = 'Friend request already sent.';
        isSuccess = false;
        setBusy(false);
        notifyListeners();
        return;
      }

      final myDoc = await _firestore.collection('Users').doc(myUid).get();

      await _firestore.collection('friend_requests').add({
        'fromUid': myUid,
        'toUid': targetUid,
        'fromName': myDoc.data()?['displayName'] ?? 'Unknown',
        'toName': targetUser.data()['displayName'] ?? 'Unknown',
        'fromEmail': myDoc.data()?['email'] ?? '',
        'toEmail': targetUser.data()['email'] ?? '',
        'status': 'pending',
        'sentAt': FieldValue.serverTimestamp(),
      });

      feedbackMessage = 'Success! Your friend request was sent.';
      isSuccess = true;
      inputValue = '';
      textController.clear();
      notifyListeners();
    } catch (e) {
      print('❌ Error: $e');
      feedbackMessage = 'Something went wrong. Try again.';
      isSuccess = false;
      notifyListeners();
    }

    setBusy(false);
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}
