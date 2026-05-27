import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:my_discord/app/app.bottomsheets.dart';
import 'package:my_discord/app/app.locator.dart';
import 'package:my_discord/app/app.router.dart';
import 'package:my_discord/models/hive_user_model.dart';
import 'package:my_discord/service/FB_Auth/Authentication.dart';
import 'package:my_discord/service/chat_service/viewService.dart';
import 'package:my_discord/ui/common/app_strings.dart';
import 'package:my_discord/ui/views/home/man_hub/friends_hub/fraind_hub_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends ReactiveViewModel implements Initialisable {
  final _auth = locator<Authentication>();
  final _bottomSheetService = locator<BottomSheetService>();
  final _navigationService = locator<NavigationService>();
  Widget _currentCenterView = const FraindHubView();
  Widget get currentCenterView => _currentCenterView;
  final _viewService = locator<ViewService>();
  Widget get currentView => _viewService.currentView;
  String get appBarTitle => _viewService.currentTitle;
  final _firestore = FirebaseFirestore.instance;

  @override
  List<ListenableServiceMixin> get listenableServices => [_viewService];

  @override
  void initialise() {
    _viewService.addListener(notifyListeners);
    listenToContactsGlobal();
  }

  void setCenterView(Widget view) {
    _currentCenterView = view;
    notifyListeners();
  }

  Future<void> logout() async {
    await _auth.logOut();
    _navigationService.clearStackAndShow(Routes.logInView);
  }

  void listenToContactsGlobal() {
    final myUid = _auth.getCurrentuser()?.uid;
    if (myUid == null) return;

    _firestore
        .collection('Contacts')
        .where('ownerId', isEqualTo: myUid)
        .snapshots()
        .listen((snapshot) async {
      final friendsBox = Hive.box<HiveUserModel>('friends_box');

      await friendsBox.clear();

      for (var doc in snapshot.docs) {
        final mapData = doc.data();
        final contactId = mapData['contactId'] ?? '';
        final ownerId = mapData['ownerId'] ?? '';

        if (contactId == myUid || ownerId != myUid) {
          continue;
        }

        HiveUserModel contactUser = HiveUserModel(
          uid: contactId,
          username: mapData['contactName'] ?? '',
          displayName: mapData['contactName'] ?? 'Unknown',
          email: mapData['email'] ?? '',
          createdAt: DateTime.now(),
          status: mapData['status'] ?? 'offline',
        );

        await friendsBox.put(contactUser.uid, contactUser);
        notifyListeners();
      }
    });
  }

  void showBottomSheet() {
    _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.notice,
      title: ksHomeBottomSheetTitle,
      description: ksHomeBottomSheetDescription,
    );
  }

  void onMenuSelected(String value) {
    switch (value) {
      case 'Advertise':
        // navigationService.navigateToNewGroupView();
        break;
      case 'Business broadcasts':
        // navigationService.navigateToNewGroupView();
        break;
      case 'Communities':
        // navigationService.navigateToNewGroupView();
        break;
      case 'Label':
        // navigationService.navigateToNewGroupView();
        break;
      case 'Linked devices':
        // navigationService.navigateTo(Routes.contactView);
        break;
      case 'starred':
        // navigationService.navigateTo(Routes.contactView);

        break;
      case 'settings':
        // navigationService.navigateTo(Routes.contactView);

        break;
    }
  }
}
