import 'package:flutter/material.dart';
import 'package:my_discord/app/app.dialogs.dart';
import 'package:my_discord/models/messsage_model.dart';
import 'package:stacked/stacked.dart';
import 'package:my_discord/app/app.locator.dart';
import 'package:stacked_services/stacked_services.dart';

class PinMessageDialogModel extends BaseViewModel {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  final _dialogService = locator<DialogService>();
  void showPinMessageDialog(MessageModel message) {
    _dialogService.showCustomDialog(
      variant: DialogType.pinMessage,
      title: 'Pin It. Pin It Good.',
      description:
          'Hey, just double checking that you want to pin this message to the current channel for posterity and greatness?',
      data: message,
      mainButtonTitle: 'Oh yeah. Pin it',
      secondaryButtonTitle: 'Cancel',
    );
  }
}
