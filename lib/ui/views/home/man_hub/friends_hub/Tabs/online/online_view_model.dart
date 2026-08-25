import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_discord/app/app.locator.dart';
import 'package:my_discord/models/user_model.dart';
import 'package:my_discord/service/FB_Auth/registration_auth.dart';
import 'package:stacked/stacked.dart';

class OnlineViewModel extends BaseViewModel {
  final _auth = locator<registrationAuth>();
  Stream<List<UserModel>> getUsersStream() {
    final myUid = _auth.getCurrentuser()?.uid;
    final firestore = FirebaseFirestore.instance;
    return firestore
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
