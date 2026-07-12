// ignore_for_file: deprecated_member_use, unnecessary_string_interpolations, camel_case_types, unreachable_switch_case

import 'package:flutter/material.dart';
import 'package:my_discord/ui/common/discord_tool_tip_extension.dart';
import 'package:my_discord/ui/common/hover_builder.dart';
import 'package:my_discord/ui/views/home/man_hub/active_or_profile/active_panel/active_panel_view.dart';
import 'package:my_discord/ui/views/home/man_hub/friends_hub/Tabs/add%20fraind/add_fraind_view.dart';
import 'package:my_discord/ui/views/home/man_hub/friends_hub/Tabs/all%20fraind/all_fraind_view.dart';
import 'package:my_discord/ui/views/home/man_hub/friends_hub/Tabs/online/online_view.dart';
import 'package:my_discord/ui/views/home/man_hub/friends_hub/Tabs/pending/pending_view.dart';
import 'package:my_discord/ui/views/home/man_hub/friends_hub/common/filter_tab_bar.dart';
import 'package:my_discord/ui/views/home/man_hub/friends_hub/common/search_bar.dart';
import 'package:my_discord/ui/views/home/man_hub/friends_hub/fraind_hub_view_model.dart';
import 'package:stacked/stacked.dart';

class FraindHubView extends StackedView<FraindHubViewModel> {
  const FraindHubView({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, FraindHubViewModel viewModel, Widget? child) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1a1a1e),
        border: Border(
          left: BorderSide(color: Colors.grey.withOpacity(0.2), width: 0.5),
        ),
      ),
      child: Column(
        children: [
          Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey.shade600,
                  width: 0.2,
                ),
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.people_alt,
                    color: Color(0xFFabacb2), size: 18),
                const SizedBox(width: 8),
                const Text(
                  'Friends',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 10),
                CircleAvatar(
                  radius: 2,
                  backgroundColor: Colors.grey.shade500,
                ),
                Expanded(child: FilterTabBar(viewModel: viewModel)),
                _FriendHeaderIcon(
                  icon: Icons.messenger_outline_outlined,
                  tooltip: 'Help',
                  onTap: () {},
                ),
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
                if (viewModel.selectedFilter != FriendFilter.addfraind)
                  ValueListenableBuilder<bool>(
                    valueListenable: viewModel.viewService.showProfileNotifier,
                    builder: (context, showProfile, _) {
                      if (viewModel.viewService.isCompact) {
                        return const SizedBox.shrink();
                      }
                      return const ActiveNowPanel();
                    },
                  ),
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
      FriendFilter.all => const AllFraindView(),
      FriendFilter.blocked => const Center(
          child:
              Text('No blocked users', style: TextStyle(color: Colors.white)),
        ),
      _ => const Text('error', style: TextStyle(color: Colors.white)),
    };
  }

  @override
  FraindHubViewModel viewModelBuilder(BuildContext context) =>
      FraindHubViewModel();
}

class _FriendHeaderIcon extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;

  const _FriendHeaderIcon({
    required this.icon,
    required this.tooltip,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return HoverBuilder(
      builder: (isHovered) => GestureDetector(
        onTap: onTap,
        child: Container(
          width: 32,
          height: 32,
          margin: const EdgeInsets.symmetric(horizontal: 0),
          decoration: BoxDecoration(
            color: isHovered ? const Color(0xFF35373C) : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: AnimatedScale(
              scale: 1.0, //isHovered ? 1.15 : 1.0,
              duration: const Duration(milliseconds: 100),
              child: Icon(
                icon,
                color: isHovered ? Colors.white : const Color(0xFFB5BAC1),
                size: 20,
              ),
            ),
          ),
        ),
      ),
    ).withDiscordTooltip(tooltip, preferBelow: true);
  }
}
