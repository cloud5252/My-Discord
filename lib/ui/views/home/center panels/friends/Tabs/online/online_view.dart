import 'package:flutter/material.dart';
import 'package:my_discord/ui/views/home/center%20panels/friends/Tabs/online/online_view_model.dart';
import 'package:stacked/stacked.dart';

class OnlineView extends StackedView<OnlineViewModel> {
  const OnlineView({super.key});

  @override
  Widget builder(
      BuildContext context, OnlineViewModel viewModel, Widget? child) {
    return const Center(
      child: Text('No Online members',
          style: TextStyle(color: Color(0xFF80848E), fontSize: 15)),
    );
  }

  @override
  OnlineViewModel viewModelBuilder(BuildContext context) => OnlineViewModel();
}
