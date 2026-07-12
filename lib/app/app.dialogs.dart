// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedDialogGenerator
// **************************************************************************

import 'package:stacked_services/stacked_services.dart';

import 'app.locator.dart';
import '../ui/dialogs/add_user/add_user_dialog.dart';
import '../ui/dialogs/confirm_action/add_user_dialog.dart';
import '../ui/dialogs/pin_messages/pin_messag_dialog.dart';

enum DialogType {
  infoAlert,
  addUser,
  pinMessage,
}

void setupDialogUi() {
  final dialogService = locator<DialogService>();

  final Map<DialogType, DialogBuilder> builders = {
    DialogType.infoAlert: (context, request, completer) =>
        InfoAlertDialog(request: request, completer: completer),
    DialogType.addUser: (context, request, completer) =>
        AddUserDialog(request: request, completer: completer),
    DialogType.pinMessage: (context, request, completer) =>
        PinMessageDialog(request: request, completer: completer),
  };

  dialogService.registerCustomDialogBuilders(builders);
}
