import 'package:flutter/material.dart';
import 'package:my_discord/ui/views/home/man_hub/message_request_tab/messag_request_view_model.dart';
import 'package:stacked/stacked.dart';

class MessageRequestsView extends StackedView<MessagRequestViewModel> {
  const MessageRequestsView({super.key});

  @override
  Widget builder(
      BuildContext context, MessagRequestViewModel viewmodel, Widget? child) {
    return const Center(
      child: Text('MessageRequestsView Tab'),
    );
  }

  @override
  MessagRequestViewModel viewModelBuilder(BuildContext context) =>
      MessagRequestViewModel();
}
