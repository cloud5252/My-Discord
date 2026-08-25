import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_discord/app/app.locator.dart';
import 'package:my_discord/service/FB_Auth/registration_auth.dart';
import 'package:stacked/stacked.dart';

class PendingViewModel extends BaseViewModel implements Initialisable {
  final _firestore = FirebaseFirestore.instance;
  final _auth = locator<registrationAuth>();

  List<Map<String, dynamic>> incomingRequests = [];
  List<Map<String, dynamic>> outgoingRequests = [];

  StreamSubscription? _incomingSub;
  StreamSubscription? _outgoingSub;

  // ← null check lagao
  String? get myUid => _auth.getCurrentuser()?.uid;

  @override
  void initialise() {
    _listenToRequests();
  }

  void _listenToRequests() {
    if (myUid == null) {
      return;
    }

    setBusy(true);

    _incomingSub = _firestore
        .collection('friend_requests')
        .where('toUid', isEqualTo: myUid)
        .where('status', isEqualTo: 'pending')
        .snapshots()
        .listen(
      (snap) {
        print('Incoming: ${snap.docs.length}');
        incomingRequests =
            snap.docs.map((d) => {'id': d.id, ...d.data()}).toList();
        setBusy(false);
        notifyListeners();
      },
      onError: (e) => print('❌ Firestore error: $e'),
    );

    _outgoingSub = _firestore
        .collection('friend_requests')
        .where('fromUid', isEqualTo: myUid)
        .where('status', isEqualTo: 'pending')
        .snapshots()
        .listen((snap) {
      print('Outgoing requests: ${snap.docs.length}');
      outgoingRequests =
          snap.docs.map((d) => {'id': d.id, ...d.data()}).toList();
      notifyListeners();
    });
  }

  Future<void> acceptRequest(String docId, String fromUid) async {
    if (myUid == null) return;

    final batch = _firestore.batch();

    // 1. Request accepted karo
    batch.update(
      _firestore.collection('friend_requests').doc(docId),
      {'status': 'accepted'},
    );

    final requestDoc =
        incomingRequests.firstWhere((r) => r['id'] == docId, orElse: () => {});
    if (requestDoc.isEmpty) return;

    final fromName = requestDoc['fromName'] ?? '';
    final toName = requestDoc['toName'] ?? '';
    final fromEmail = requestDoc['fromEmail'] ?? '';
    final toEmail = requestDoc['toEmail'] ?? '';

    batch.set(
      _firestore
          .collection('Users')
          .doc(myUid)
          .collection('friends')
          .doc(fromUid),
      {
        'friendId': fromUid,
        'friendName': fromName,
        'friendEmail': fromEmail,
        'addedAt': FieldValue.serverTimestamp(),
      },
    );

    batch.set(
      _firestore
          .collection('Users')
          .doc(fromUid)
          .collection('friends')
          .doc(myUid),
      {
        'friendId': myUid,
        'friendName': toName,
        'friendEmail': toEmail,
        'addedAt': FieldValue.serverTimestamp(),
      },
    );

    await batch.commit();
  }

  Future<void> rejectRequest(String docId) async {
    await _firestore
        .collection('friend_requests')
        .doc(docId)
        .update({'status': 'rejected'});
  }

  Future<void> cancelRequest(String docId) async {
    await _firestore.collection('friend_requests').doc(docId).delete();
  }

  @override
  void dispose() {
    _incomingSub?.cancel();
    _outgoingSub?.cancel();
    super.dispose();
  }
}
