import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_discord/app/app.locator.dart';
import 'package:my_discord/models/hive_user_model.dart';
import 'package:my_discord/service/viewService.dart';
import 'package:my_discord/ui/views/home/man_hub/message_request_tab/messsag_request_view.dart';
import 'package:my_discord/ui/views/home/man_hub/nitro_tab/nitro_view.dart';
import 'package:my_discord/ui/views/home/man_hub/quests_tab/quests_view.dart';
import 'package:my_discord/ui/views/home/man_hub/shop_tab/shop_view.dart';
import 'package:my_discord/ui/views/home/man_hub/chat/chat_view.dart';
import 'package:my_discord/ui/views/home/man_hub/friends_hub/fraind_hub_view.dart';
import 'package:stacked/stacked.dart';

enum SidebarTab { friends, messageRequests, nitro, shop, quests }

class DmSideViewModel extends BaseViewModel implements Initialisable {
  final _viewService = locator<ViewService>();
  final _firestore = FirebaseFirestore.instance;

  List<HiveUserModel> _friends = [];
  List<HiveUserModel> get friends => _friends;

  StreamSubscription? _friendsSubscription;

  SidebarTab? _activeTab = SidebarTab.friends;
  SidebarTab? get activeTab => _activeTab;
  String? get currentChatId => _viewService.currentId;

  @override
  void initialise() {
    _viewService.addListener(_onViewChanged);
    _listenToFriends();
  }

  void _listenToFriends() {
    final myUid = FirebaseAuth.instance.currentUser?.uid;
    if (myUid == null) return;

    setBusy(true);

    _friendsSubscription = _firestore
        .collection('Users')
        .doc(myUid)
        .collection('friends')
        .snapshots()
        .listen((snapshot) async {
      final List<HiveUserModel> loadedFriends = [];

      for (var doc in snapshot.docs) {
        final data = doc.data();
        final friendId = data['friendId'] as String;

        final userDoc =
            await _firestore.collection('Users').doc(friendId).get();
        if (!userDoc.exists) continue;
        final userData = userDoc.data()!;

        loadedFriends.add(HiveUserModel(
          uid: friendId,
          username: userData['username'] ?? '',
          displayName:
              userData['displayName'] ?? data['friendName'] ?? 'Unknown',
          email: userData['email'] ?? data['friendEmail'] ?? '',
          createdAt: DateTime.now(),
          status: userData['status'] ?? 'offline',
        ));
      }

      _friends = loadedFriends;
      setBusy(false);
      notifyListeners();
    });
  }

  void _onViewChanged() {
    notifyListeners();
  }

  @override
  void dispose() {
    _viewService.removeListener(_onViewChanged);
    _friendsSubscription?.cancel();
    super.dispose();
  }

  void navigateToChat(HiveUserModel friend) {
    _activeTab = null;
    notifyListeners();

    final id = friend.uid;
    final name = friend.displayName;

    _viewService.setView(
      ChatView(
        key: ValueKey(id),
        chatWithId: id,
        chatWithName: name,
      ),
      title: name,
      id: id,
    );
  }

  void onTabTap(SidebarTab tab) {
    _activeTab = tab;
    _viewService.currentId = null;
    notifyListeners();

    switch (tab) {
      case SidebarTab.friends:
        _viewService.setView(const FraindHubView(), title: "Friends");
      case SidebarTab.messageRequests:
        _viewService.setView(const MessageRequestsView(),
            title: "Message Requests");
      case SidebarTab.nitro:
        _viewService.setView(const NitroView(), title: "Nitro");
      case SidebarTab.shop:
        _viewService.setView(const ShopView(), title: "Shop");
      case SidebarTab.quests:
        _viewService.setView(const QuestsView(), title: "Quests");
    }
  }
}
