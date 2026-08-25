import 'package:flutter/material.dart';
import 'package:my_discord/app/app.bottomsheets.dart';
import 'package:my_discord/app/app.locator.dart';
import 'package:my_discord/app/app.router.dart';
import 'package:my_discord/service/FB_Auth/registration_auth.dart';
import 'package:my_discord/service/viewService.dart';
import 'package:my_discord/ui/common/app_strings.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends ReactiveViewModel implements Initialisable {
  final _bottomSheetService = locator<BottomSheetService>();
  final _navigationService = locator<NavigationService>();
  final _auth = locator<registrationAuth>();
  final _viewService = locator<ViewService>();

  Widget get currentView => _viewService.currentView;
  String get appBarTitle => _viewService.currentTitle;
  String? get currentId => _viewService.currentId;

  @override
  List<ListenableServiceMixin> get listenableServices => [_viewService];

  @override
  void initialise() {}

  Future<void> logout() async {
    await _auth.logOut();
    _navigationService.clearStackAndShow(Routes.authView);
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
