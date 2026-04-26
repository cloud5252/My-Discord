import 'package:flutter/material.dart';
import 'package:my_discord/service/FB_Auth/Authentication.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:my_discord/app/app.locator.dart';
import 'package:my_discord/app/app.router.dart';

class LogInViewModel extends BaseViewModel {
  // Services ko locator se lein
  final TextEditingController Emailcontroller = TextEditingController();
  final TextEditingController displaynamecontroller = TextEditingController();
  final TextEditingController usernamecontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  final _auth = locator<Authentication>();

  void navigateToLogin() {
    _navigationService.navigateToSignInView();
  }

  void register() async {
    if (passwordcontroller.text.isEmpty) return;

    setBusy(true);
    try {
      await _auth.createdAccount(usernamecontroller.text, Emailcontroller.text,
          passwordcontroller.text, displaynamecontroller.text,);

      await Future.delayed(const Duration(milliseconds: 500));

      _navigationService.replaceWithHomeView();
    } catch (e) {
      await _dialogService.showDialog(
          title: 'Error', description: e.toString());
    } finally {
      setBusy(false);
    }
  }
}
