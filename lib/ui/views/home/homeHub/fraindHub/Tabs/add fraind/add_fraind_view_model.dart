import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_discord/app/app.locator.dart';
import 'package:my_discord/service/FB_Auth/Authentication.dart';
import 'package:stacked/stacked.dart';

class AddFraindViewModel extends BaseViewModel {
  final _auth = locator<Authentication>();
  final _firestore = FirebaseFirestore.instance;

  String inputValue = '';
  String? feedbackMessage;
  bool isSuccess = false;

  void onInputChanged(String value) {
    inputValue = value;
    feedbackMessage = null; // message clear karo jab type kare
    notifyListeners();
  }

  Future<void> sendFriendRequest() async {
    setBusy(true);
    feedbackMessage = null;

    try {
      final myUid = _auth.getCurrentuser()?.uid;
      if (myUid == null) return;

      // Target user dhundo
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
        return;
      }

      final targetUser = query.docs.first;
      final targetUid = targetUser.id;

      // Khud ko add na kare
      if (targetUid == myUid) {
        feedbackMessage = 'You cannot send a request to yourself.';
        isSuccess = false;
        setBusy(false);
        return;
      }

      // Pehle se request check karo
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
        return;
      }

      // Apna data fetch karo — alag se
      final myDoc = await _firestore.collection('Users').doc(myUid).get();

      // Request bhejo
      await _firestore.collection('friend_requests').add({
        'fromUid': myUid,
        'toUid': targetUid,
        'fromName': myDoc.data()?['displayName'] ?? 'Unknown', // ← fix
        'toName': targetUser.data()['displayName'] ?? 'Unknown',
        'status': 'pending',
        'sentAt': FieldValue.serverTimestamp(),
      });

      feedbackMessage = 'Success! Your friend request was sent.';
      isSuccess = true;
      inputValue = '';
    } catch (e) {
      print('❌ Error: $e');
      feedbackMessage = 'Something went wrong. Try again.';
      isSuccess = false;
    }

    setBusy(false);
  }
}
