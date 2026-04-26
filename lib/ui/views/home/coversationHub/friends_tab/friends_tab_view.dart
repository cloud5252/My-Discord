import 'package:flutter/material.dart';
import 'package:my_discord/ui/views/home/coversationHub/friends_tab/friends_tab_view_model.dart';
import 'package:stacked/stacked.dart';

class FriendsTabView extends StackedView<FriendsTabViewModel> {
  const FriendsTabView({super.key});

  @override
  Widget builder(
      BuildContext context, FriendsTabViewModel viewmodel, Widget? child) {
    return const Center(
      child: Text('frainds Tab'),
    );
  }

  @override
  FriendsTabViewModel viewModelBuilder(BuildContext context) =>
      FriendsTabViewModel();
}
