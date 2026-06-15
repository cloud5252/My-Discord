// ignore_for_file: deprecated_member_use, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:my_discord/ui/common/hover_builder.dart';
import 'package:my_discord/ui/common/press_builder.dart';
import 'package:my_discord/ui/views/home/man_hub/friends_hub/common/filter_tab_style.dart';
import 'package:my_discord/ui/views/home/man_hub/friends_hub/fraind_hub_view_model.dart';

class FilterTabBar extends StatelessWidget implements PreferredSizeWidget {
  final FraindHubViewModel viewModel;

  const FilterTabBar({Key? key, required this.viewModel}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(44);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      // color: const Color(0xFF1a1a1e),
      child: ListView(
        key: const Key('filter_tab_bar_list'),
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        children: [
          _TabChip(
              label: 'Online',
              filter: FriendFilter.online,
              viewModel: viewModel),
          _TabChip(
              label: 'All', filter: FriendFilter.all, viewModel: viewModel),
          _TabChip(
              label: 'Pending',
              filter: FriendFilter.pending,
              viewModel: viewModel),
          _TabChip(
              label: 'Blocked',
              filter: FriendFilter.blocked,
              viewModel: viewModel),
          _TabChip(
              label: 'Add Friend',
              filter: FriendFilter.addfraind,
              viewModel: viewModel),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}

class _TabChip extends StatelessWidget {
  final String label;
  final FriendFilter filter;
  final FraindHubViewModel viewModel;

  const _TabChip({
    Key? key,
    required this.label,
    required this.filter,
    required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isActive = viewModel.selectedFilter == filter;

    return HoverBuilder(
      builder: (isHovered) {
        return PressBuilder(
          onTap: () => viewModel.setFilter(filter),
          builder: (isPressed) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 120),
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              decoration: BoxDecoration(
                color: FilterTabStyle.getBgColor(
                  filter: filter,
                  isActive: isActive,
                  isHovered: isHovered,
                  isPressed: isPressed,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                label,
                style: TextStyle(
                  color: FilterTabStyle.getTextColor(
                    filter: filter,
                    isActive: isActive,
                    isHovered: isHovered,
                  ),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
