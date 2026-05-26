import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_discord/app/app.locator.dart';
import 'package:my_discord/service/FB_Auth/Authentication.dart';
import 'package:my_discord/service/chat_service/viewService.dart';
import 'package:my_discord/ui/views/home/man_hub/message_request_tab/messsag_request_view.dart';
import 'package:my_discord/ui/views/home/man_hub/nitro_tab/nitro_view.dart';
import 'package:my_discord/ui/views/home/man_hub/quests_tab/quests_view.dart';
import 'package:my_discord/ui/views/home/man_hub/shop_tab/shop_view.dart';
import 'package:my_discord/ui/views/home/man_hub/chat/chat_view.dart';
import 'package:my_discord/ui/views/home/man_hub/friends_hub/fraind_hub_view.dart';
import 'package:stacked/stacked.dart';

enum SidebarTab { friends, messageRequests, nitro, shop, quests }

class DmSideViewModel extends BaseViewModel implements Initialisable {
  final _auth = locator<Authentication>();
  final _viewService = locator<ViewService>();
  final _firestore = FirebaseFirestore.instance;

  SidebarTab? _activeTab = SidebarTab.friends;
  SidebarTab? get activeTab => _activeTab;
  String? get currentChatId => _viewService.currentId;
  StreamSubscription? _contactsSub;

  List<Map<String, dynamic>>? data;

  @override
  void initialise() {
    _listenToContacts();
    _viewService.addListener(_onViewChanged);
  }

  void _onViewChanged() {
    notifyListeners();
  }

  @override
  void dispose() {
    _contactsSub?.cancel();
    _viewService.removeListener(_onViewChanged);
    super.dispose();
  }

  void _listenToContacts() {
    setBusy(true);
    final myUid = _auth.getCurrentuser()?.uid;
    if (myUid == null) {
      setBusy(false);
      return;
    }

    _contactsSub = _firestore
        .collection('Contacts')
        .where('ownerId', isEqualTo: myUid)
        .snapshots()
        .listen((snapshot) {
      data = snapshot.docs.map((doc) => doc.data()).toList();
      setBusy(false);
      notifyListeners();
    });
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

  void navigateToChat(Map<String, dynamic> friend) {
    _activeTab = null;
    notifyListeners();
    final id = friend['contactId'] ?? '';
    final name = friend['contactName'] ?? 'Unknown';

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
}
