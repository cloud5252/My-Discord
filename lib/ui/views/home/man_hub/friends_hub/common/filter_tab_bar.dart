import 'package:flutter/material.dart';
 import 'package:my_discord/ui/views/home/man_hub/friends_hub/fraind_hub_view_model.dart';

class FilterTabBar extends StatelessWidget implements PreferredSizeWidget {
  final FraindHubViewModel viewModel;

  const FilterTabBar({Key? key, required this.viewModel}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(44);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      color: const Color(0xFF1a1a1e),
      child: ListView(
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
              label: 'AddFraind',
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
    final bool isAddFriendTab = filter == FriendFilter.addfraind;

    Color getBgColor() {
      if (isAddFriendTab) {
        return isActive
            ? const Color(0xFF363e8e).withOpacity(0.5)
            : const Color(0xFF5a68ed);
      }

      return isActive ? const Color(0xFF404249) : Colors.transparent;
    }

    Color getTextColor() {
      if (isAddFriendTab) {
        return isActive ? const Color(0xFF5a68ed) : Colors.white;
      }
      return isActive ? Colors.white : const Color(0xFFB5BAC1);
    }

    return GestureDetector(
      onTap: () => viewModel.setFilter(filter),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 350),
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        decoration: BoxDecoration(
          color: getBgColor(),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: getTextColor(),
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
