import 'package:my_discord/app/app.dialogs.dart';
import 'package:my_discord/models/messsage_model.dart';
import 'package:stacked/stacked.dart';
import 'package:my_discord/app/app.locator.dart';
import 'package:stacked_services/stacked_services.dart';

class UnpinMessageDialogModel extends BaseViewModel {
  final _dialogService = locator<DialogService>();

  Future<bool> showUnpinMessageDialog(MessageModel message) async {
    final response = await _dialogService.showCustomDialog(
      variant: DialogType.unpinMessage,
      title: 'Unpin Message',
      description: 'You sure you want to remove this pinned message?',
      data: message,
      mainButtonTitle: 'Remove it please!',
      secondaryButtonTitle: 'Cancel',
    );

    return response?.confirmed ?? false;
  }
}
