import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_discord/app/app.locator.dart';
import 'package:my_discord/service/FB_Auth/Authentication.dart';
import 'package:my_discord/service/chat_service/viewService.dart';
import 'package:my_discord/ui/views/home/coversationHub/message_request_tab/messsag_request_view.dart';
import 'package:my_discord/ui/views/home/coversationHub/nitro_tab/nitro_view.dart';
import 'package:my_discord/ui/views/home/coversationHub/quests_tab/quests_view.dart';
import 'package:my_discord/ui/views/home/coversationHub/shop_tab/shop_view.dart';
import 'package:my_discord/ui/views/home/homeHub/chat/chat_view.dart';
import 'package:my_discord/ui/views/home/homeHub/fraindHub/fraind_hub_view.dart';
import 'package:stacked/stacked.dart';

enum SidebarTab { friends, messageRequests, nitro, shop, quests }

class DmSideViewModel extends BaseViewModel implements Initialisable {
  final _auth = locator<Authentication>();
  final _viewService = locator<ViewService>();
  final _firestore = FirebaseFirestore.instance;

  SidebarTab _activeTab = SidebarTab.friends;
  SidebarTab get activeTab => _activeTab;

  StreamSubscription? _contactsSub;

  List<Map<String, dynamic>>? data;

  @override
  void initialise() {
    _listenToContacts();
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

  // ─── Tab switch ────────────────────────────────────────
  void onTabTap(SidebarTab tab) {
    _activeTab = tab;
    notifyListeners();

    switch (tab) {
      case SidebarTab.friends:
        _viewService.setView(const FraindHubView());
      case SidebarTab.messageRequests:
        _viewService.setView(const MessageRequestsView());
      case SidebarTab.nitro:
        _viewService.setView(const NitroView());
      case SidebarTab.shop:
        _viewService.setView(const ShopView());
      case SidebarTab.quests:
        _viewService.setView(const QuestsView());
    }
  }

  void navigateToChat(Map<String, dynamic> friend) {
    _viewService.setView(
      ChatView(
        chatWithId: friend['contactId'] ?? '',
        chatWithName: friend['contactName'] ?? 'Unknown',
      ),
    );
  }

  @override
  void dispose() {
    _contactsSub?.cancel();
    super.dispose();
  }
}
