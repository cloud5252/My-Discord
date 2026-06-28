import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_ce/hive.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:my_discord/app/app.locator.dart';
import 'package:my_discord/app/app.router.dart';
import 'package:my_discord/models/hive_user_model.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  String loadingText = 'Connecting...';

  Future<void> runStartupLogic() async {
    await Hive.box('prefs_box').clear();

    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      _navigationService.replaceWithAuthView();
      return;
    }

    loadingText = 'Fetching your friends...';
    notifyListeners();
    await _loadFriends(user.uid);

    loadingText = 'Almost there...';
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 500));

    _navigationService.replaceWithHomeView();
  }

  Future<void> _loadFriends(String myUid) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc(myUid)
          .collection('friends')
          .get();

      final friendsBox = Hive.box<HiveUserModel>('friends_box');
      await friendsBox.clear();

      for (var doc in snapshot.docs) {
        final data = doc.data();

        final friend = HiveUserModel(
          uid: doc.id,
          username: data['friendName'] ?? '',
          displayName: data['friendName'] ?? 'Unknown',
          email: data['friendEmail'] ?? '',
          createdAt: DateTime.now(),
          status: data['status'] ?? 'offline',
        );

        await friendsBox.put(friend.uid, friend);
      }
    } catch (e) {
      print('❌ Friends load error: $e');
    }
  }
}
