// ignore_for_file: unreachable_switch_case

import 'package:flutter/material.dart';
import 'package:my_discord/ui/views/home/homeHub/fraindHub/Tabs/add%20fraind/add_fraind_view.dart';
import 'package:my_discord/ui/views/home/homeHub/fraindHub/common/filter_tab_bar.dart';
import 'package:my_discord/ui/views/home/homeHub/fraindHub/common/search_bar.dart';
import 'package:my_discord/ui/views/home/homeHub/fraindHub/common/popup_menu.dart';
import 'package:my_discord/ui/views/home/homeHub/fraindHub/fraind_hub_view_model.dart';
import 'package:my_discord/ui/views/home/homeHub/fraindHub/Tabs/online/online_view.dart';
import 'package:my_discord/ui/views/home/homeHub/fraindHub/Tabs/pending/pending_view.dart';
import 'package:stacked/stacked.dart';

class FraindHubView extends StackedView<FraindHubViewModel> {
  const FraindHubView({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, FraindHubViewModel viewModel, Widget? child) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF313338), // Discord ka standard background
        border: Border(
          left: BorderSide(
            color: Colors.grey.withOpacity(0.2),
            width: 0.5,
          ),
        ),
      ),
      child: Column(
        children: [
          if (viewModel.selectedFilter == FriendFilter.blocked ||
              viewModel.selectedFilter == FriendFilter.all)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: FriendsSearchBar(viewModel: viewModel),
            ),

          // Body
          Expanded(child: _buildBody(viewModel)),
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
              style: TextStyle(color: Color(0xFF80848E))),
        ),
      FriendFilter.all => const Center(
          child: Text('not found', style: TextStyle(color: Color(0xFF80848E))),
        ),
      _ => const Text('error'),
    };
  }

  @override
  FraindHubViewModel viewModelBuilder(BuildContext context) =>
      FraindHubViewModel();
}

class _FriendsHeader extends StatelessWidget {
  final FraindHubViewModel viewModel;
  const _FriendsHeader({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF1E2124),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => viewModel.logout(),
            child: const Text('Friends Logout',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600)),
          ),
          const Spacer(),
          const ChatPopupMenu(),
        ],
      ),
    );
  }
}

class _fraindstag extends StatelessWidget {
  const _fraindstag({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
