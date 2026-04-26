import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:my_discord/app/app.locator.dart';
import 'package:my_discord/app/app_enums.dart';
import 'package:stacked_services/stacked_services.dart';

class AddUserDialogModel extends BaseViewModel {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  final _snackbarService = locator<SnackbarService>();
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
}
