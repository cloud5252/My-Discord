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
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends ReactiveViewModel implements Initialisable {
  final friendsBox = Hive.box<HiveUserModel>('friends_box');

  final _bottomSheetService = locator<BottomSheetService>();
  final _navigationService = locator<NavigationService>();
  final _firestore = FirebaseFirestore.instance;
  final _auth = locator<Authentication>();
  final _viewService = locator<ViewService>();

  Widget get currentView => _viewService.currentView;
  String get appBarTitle => _viewService.currentTitle;
  String? get currentId => _viewService.currentId;

  @override
  List<ListenableServiceMixin> get listenableServices => [_viewService];

  @override
  void initialise() {
    listenToContactsGlobal();
  }

  Future<void> logout() async {
    await _auth.logOut();
    _navigationService.clearStackAndShow(Routes.authView);
  }

  void listenToContactsGlobal() {
    final myUid = _auth.getCurrentuser()?.uid;
    if (myUid == null) return;

    _firestore
        .collection('Users')
        .doc(myUid)
        .collection('friends')
        .snapshots()
        .listen((snapshot) async {
      await friendsBox.clear();

      for (var doc in snapshot.docs) {
        final mapData = doc.data();

        HiveUserModel contactUser = HiveUserModel(
          uid: doc.id,
          username: mapData['friendName'] ?? '',
          displayName: mapData['friendName'] ?? 'Unknown',
          email: mapData['friendEmail'] ?? '',
          createdAt: DateTime.now(),
          status: mapData['status'] ?? 'online',
        );

        await friendsBox.put(contactUser.uid, contactUser);
      }

      notifyListeners();
    });
  }

  void showBottomSheet() {
    _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.notice,
      title: ksHomeBottomSheetTitle,
      description: ksHomeBottomSheetDescription,
    );
  }

  void onMenuSelected(String value) {}
  static const double responsiveBreakpoint = 1250.0;

  double _screenWidth = 0.0;
  bool _isCompactSize = false;

  bool get isCompactSize => _isCompactSize;

  void updateScreenWidth(double width) {
    if (_screenWidth == width) return;
    _screenWidth = width;

    final currentCompact = width < responsiveBreakpoint;

    if (_isCompactSize != currentCompact) {
      _isCompactSize = currentCompact;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        _viewService.isCompact = currentCompact;
        _viewService.setProfileVisibility(!currentCompact,
            isResponsiveTrigger: true);
        notifyListeners();
      });
    }
  }
}
