// ignore_for_file: unreachable_switch_case

import 'package:flutter/material.dart';
import 'package:my_discord/ui/views/home/man_hub/friends_hub/Tabs/add%20fraind/add_fraind_view.dart';
import 'package:my_discord/ui/views/home/man_hub/friends_hub/Tabs/online/online_view.dart';
import 'package:my_discord/ui/views/home/man_hub/friends_hub/Tabs/pending/pending_view.dart';
import 'package:my_discord/ui/views/home/man_hub/friends_hub/common/filter_tab_bar.dart';
import 'package:my_discord/ui/views/home/man_hub/friends_hub/common/popup_menu.dart';
import 'package:my_discord/ui/views/home/man_hub/friends_hub/common/search_bar.dart';
import 'package:my_discord/ui/views/home/man_hub/friends_hub/fraind_hub_view_model.dart';
import 'package:my_discord/ui/views/home/widget/My_active_now_panel.dart';
import 'package:stacked/stacked.dart';

class FraindHubView extends StackedView<FraindHubViewModel> {
  const FraindHubView({
    Key? key,
  }) : super(key: key);

  @override
  Widget builder(
      BuildContext context, FraindHubViewModel viewModel, Widget? child) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1a1a1e),
        border: Border(
          left: BorderSide(
            color: Colors.grey.withOpacity(0.2),
            width: 0.5,
          ),
        ),
      ),
      child: Column(
        children: [
          Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Color(0xFF1E1F22), width: 1.5),
              ),
            ),
            child: Row(
              children: [
                const _tabtag(),
                const SizedBox(width: 16),
                Expanded(child: FilterTabBar(viewModel: viewModel)),
                const ChatPopupMenu(),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      if (viewModel.selectedFilter == FriendFilter.blocked ||
                          viewModel.selectedFilter == FriendFilter.all ||
                          viewModel.selectedFilter == FriendFilter.online ||
                          viewModel.selectedFilter == FriendFilter.pending)
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: FriendsSearchBar(viewModel: viewModel),
                        ),
                      Expanded(child: _buildBody(viewModel)),
                    ],
                  ),
                ),
                const ActiveNowPanel(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(FraindHubViewModel viewModel) {
    return switch (viewModel.selectedFilter) {
      FriendFilter.pending => const PendingView(),
      FriendFilter.online => const OnlineView(),
      FriendFilter.addfraind => const AddFraindView(),
      FriendFilter.blocked => const Center(
          child: Text('No blocked users',
              style: TextStyle(color: Color(0xFF1a1a1e))),
        ),
      FriendFilter.all => const Center(
          child: Text('not found', style: TextStyle(color: Color(0xFF1a1a1e))),
        ),
      _ => const Text('error'),
    };
  }

  @override
  FraindHubViewModel viewModelBuilder(BuildContext context) =>
      FraindHubViewModel();
}

class _tabtag extends StatelessWidget {
  const _tabtag();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.people_alt, color: Color(0xFFabacb2), size: 18),
        SizedBox(width: 8),
        Text(
          'Friends',
          style: TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
