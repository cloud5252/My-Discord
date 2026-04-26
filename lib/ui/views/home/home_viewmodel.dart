import 'package:flutter/material.dart';
import 'package:my_discord/app/app.bottomsheets.dart';
import 'package:my_discord/app/app.dialogs.dart';
import 'package:my_discord/app/app.locator.dart';
import 'package:my_discord/app/app.router.dart';
import 'package:my_discord/service/FB_Auth/Authentication.dart';
import 'package:my_discord/service/chat_service/viewService.dart';
import 'package:my_discord/ui/common/app_strings.dart';
import 'package:my_discord/ui/views/home/homeHub/fraindHub/fraind_hub_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel implements Initialisable {
  final _dialogService = locator<DialogService>();
  final _auth = locator<Authentication>();
  final _bottomSheetService = locator<BottomSheetService>();
  final _navigationService = locator<NavigationService>();
  Widget _currentCenterView = const FraindHubView();
  Widget get currentCenterView => _currentCenterView;
  final viewService = locator<ViewService>();
  final _viewService = locator<ViewService>();

  Widget get currentView => _viewService.currentView;
  @override
  void initialise() {
    // ViewService changes pe rebuild karo
    _viewService.addListener(notifyListeners);
  }

  @override
  void dispose() {
    _viewService.removeListener(notifyListeners);
    super.dispose();
  }

  void setCenterView(Widget view) {
    _currentCenterView = view;
    notifyListeners();
  }

  String get counterLabel => 'Counter is: $_counter';

  int _counter = 0;

  void incrementCounter() {
    _counter++;
    rebuildUi();
  }

  Future<void> logout() async {
    await _auth.logOut();
    _navigationService.clearStackAndShow(Routes.logInView);
  }

  void showDialog() {
    _dialogService.showCustomDialog(
      variant: DialogType.infoAlert,
      title: 'Stacked Rocks!',
      description: 'Give stacked $_counter stars on Github',
    );
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
