import 'package:flutter/material.dart';
import 'package:my_discord/ui/common/app_colors.dart';
import 'package:my_discord/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:my_discord/ui/dialogs/add_user/component/My_add_user_text_feilds.dart';
import 'package:stacked_services/stacked_services.dart';
import 'add_user_dialog_model.dart';

class AddUserDialog extends StackedView<AddUserDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const AddUserDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AddUserDialogModel viewModel,
    Widget? child,
  ) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: backgroundDartMode,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              request.title ?? 'Hello Stacked Dialog!!',
              style: const TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w900, color: whiteColor),
            ),
            if (request.description != null) ...[
              verticalSpaceTiny,
              Text(
                request.description!,
                style: const TextStyle(
                  fontSize: 16,
                  color: whiteColor,
                ),
                maxLines: 3,
                softWrap: true,
              ),
            ],
            verticalSpaceMedium,
            MyAddUserTextFeilds(
              controller: viewModel.namecontroller,
              obsecurtext: false,
              hinttext: 'Name',
            ),
            verticalSpaceSmall,
            MyAddUserTextFeilds(
              controller: viewModel.emailcontroller,
              obsecurtext: false,
              hinttext: 'Email',
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Cancel Button
                TextButton(
                  onPressed: () => completer(DialogResponse(confirmed: false)),
                  child: Text(
                    request.secondaryButtonTitle ?? 'Cancel',
                    style: const TextStyle(fontSize: 16, color: whiteColor),
                  ),
                ),
                TextButton(
                  onPressed: () =>
                      completer(DialogResponse(confirmed: true, data: {
                    'name': viewModel.namecontroller.text,
                    'email': viewModel.emailcontroller.text,
                  })),
                  child: Text(
                    request.mainButtonTitle ?? 'Conforme',
                    style: const TextStyle(color: greenColor, fontSize: 18),
                  ),
                ),

                // Confirm Button
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  AddUserDialogModel viewModelBuilder(BuildContext context) =>
      AddUserDialogModel();
}
