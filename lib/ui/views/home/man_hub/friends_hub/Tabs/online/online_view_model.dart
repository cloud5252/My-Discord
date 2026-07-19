import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_discord/app/app.locator.dart';
import 'package:my_discord/models/user_model.dart';
import 'package:my_discord/service/FB_Auth/Authentication.dart';
import 'package:stacked/stacked.dart';

class OnlineViewModel extends BaseViewModel {
  final _auth = locator<Authentication>();
  Stream<List<UserModel>> getUsersStream() {
    final myUid = _auth.getCurrentuser()?.uid;
    final _firestore = FirebaseFirestore.instance;
    return _firestore
        .collection('Users')
        .where('status', isEqualTo: 'online')
        .snapshots()
        .map((snapshot) {
      List<UserModel> usersList = [];

      for (var doc in snapshot.docs) {
        var data = doc.data();

        if (data['uid'] == myUid) continue;

        usersList.add(
          UserModel(
            uid: data['uid'] ?? '',
            username: data['username'] ?? '',
            displayName: data['displayName'] ?? data['username'] ?? 'No Name',
            email: data['email'] ?? '',
            status: data['status'] ?? 'offline',
            createdAt: DateTime.now(),
          ),
        );
      }
      return usersList;
    });
  }
}
