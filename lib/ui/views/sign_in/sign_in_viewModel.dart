import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_discord/app/app.router.dart';
import 'package:my_discord/service/FB_Auth/Authentication.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:my_discord/app/app.locator.dart';
import 'package:my_discord/app/app_enums.dart';

class SigInViewModel extends BaseViewModel {
  final Emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final auth = locator<Authentication>();
  final _navigationService = locator<NavigationService>();
  final _snackbarService = locator<SnackbarService>();
  final fbauth = locator<Authentication>();
  // final _chatService = locator<ChatService>();

  void navigateToRegister() {
    _navigationService.back();
  }

  void showUserAddedMessage() {
    _snackbarService.showCustomSnackBar(
      variant: SnackbarType.success,
      title: 'Success',
      message: 'User has been ad successfully! ✅',
      duration: const Duration(seconds: 3),
      onTap: (result) {
        print('Snackbar tapped!');
      },
    );
  }

  Future<void> signIn() async {
    setBusy(true);
    try {
      await auth.signIn(Emailcontroller.text, passwordcontroller.text);
      final User? currentUser = fbauth.getCurrentuser();
      if (currentUser != null) {
        _navigationService.replaceWithHomeView();
      }
    } catch (e) {
      _snackbarService.showSnackbar(message: e.toString());
    } finally {
      setBusy(false);
    }
  }
}
