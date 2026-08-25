import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_discord/app/app.router.dart';
import 'package:my_discord/service/FB_Auth/registration_auth.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:my_discord/app/app.locator.dart';
import 'package:my_discord/app/app_enums.dart';

class SigInViewModel extends BaseViewModel implements Initialisable {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  final _navigationService = locator<NavigationService>();
  final _snackbarService = locator<SnackbarService>();
  final fbauth = locator<registrationAuth>();
  final auth = locator<registrationAuth>();

  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();

  bool get isPasswordFocused => passwordFocusNode.hasFocus;
  bool get isEmailFocused => emailFocusNode.hasFocus;

  @override
  void initialise() {
    emailFocusNode.addListener(notifyListeners);
    passwordFocusNode.addListener(notifyListeners);
  }

  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  void navigateToRegister() {
    _navigationService.back();
  }

  void showUserAddedMessage() {
    _snackbarService.showCustomSnackBar(
      variant: SnackbarType.success,
      title: 'Success',
      message: 'User has been ad successfully!',
      duration: const Duration(seconds: 3),
      onTap: (result) {
        print('Snackbar tapped!');
      },
    );
  }

  String? _authError;
  String? get authError => _authError;

  Future<void> signIn() async {
    _authError = null;
    setBusy(true);
    try {
      await auth.signIn(emailcontroller.text, passwordcontroller.text);
      final User? currentUser = fbauth.getCurrentuser();
      if (currentUser != null) {
        _navigationService.replaceWithHomeView();
      }
    } catch (e) {
      _authError = 'Invalid email or password';
      notifyListeners();
    } finally {
      setBusy(false);
    }
  }
}
