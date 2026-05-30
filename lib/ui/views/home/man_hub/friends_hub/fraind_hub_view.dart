// ignore_for_file: unnecessary_string_interpolations, camel_case_types, unreachable_switch_case

import 'package:flutter/material.dart';
import 'package:my_discord/app/app.locator.dart';
import 'package:my_discord/service/chat_service/viewService.dart';
import 'package:my_discord/ui/common/discord_tool_tip_extension.dart';
import 'package:my_discord/ui/common/hover_builder.dart';
import 'package:my_discord/ui/views/home/man_hub/friends_hub/Tabs/add%20fraind/add_fraind_view.dart';
import 'package:my_discord/ui/views/home/man_hub/friends_hub/Tabs/all%20fraind/all_fraind_view.dart';
import 'package:my_discord/ui/views/home/man_hub/friends_hub/Tabs/online/online_view.dart';
import 'package:my_discord/ui/views/home/man_hub/friends_hub/Tabs/pending/pending_view.dart';
import 'package:my_discord/ui/views/home/man_hub/friends_hub/common/filter_tab_bar.dart';
import 'package:my_discord/ui/views/home/man_hub/friends_hub/common/search_bar.dart';
import 'package:my_discord/ui/views/home/man_hub/friends_hub/fraind_hub_view_model.dart';
import 'package:my_discord/ui/views/home/man_hub/panel_hub/active_panel/active_panel_view.dart';
import 'package:my_discord/ui/views/home/man_hub/panel_hub/profile_panel/profile_panel_view.dart';
import 'package:stacked/stacked.dart';

class FraindHubView extends StackedView<FraindHubViewModel> {
  const FraindHubView({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, FraindHubViewModel viewModel, Widget? child) {
    final viewService = locator<ViewService>();
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
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Color(0xFF2c2c30), width: 1.0),
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
                Container(
                  width: 1,
                  height: 20,
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  color: const Color(0xFF3F4147),
                ),
                Expanded(child: FilterTabBar(viewModel: viewModel)),
                _FriendHeaderIcon(
                  icon: Icons.inbox,
                  tooltip: 'New Group DM',
                  onTap: () {},
                ),
                _FriendHeaderIcon(
                  icon: Icons.help_outline,
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
                  switch (viewService.rightPanel) {
                    RightPanel.profile =>
                      ProfilePanel(userId: viewService.currentId ?? ''),
                    RightPanel.activeNow => const ActiveNowPanel(),
                    RightPanel.none => const SizedBox.shrink(),
                  },
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
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: isHovered ? const Color(0xFF35373C) : Colors.transparent,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: AnimatedScale(
              scale: isHovered ? 1.15 : 1.0,
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
