import 'package:flutter/material.dart';
import 'package:my_discord/ui/views/home/homeHub/fraindHub/fraind_hub_view_model.dart';

class FilterTabBar extends StatelessWidget implements PreferredSizeWidget {
  final FraindHubViewModel viewModel;

  const FilterTabBar({Key? key, required this.viewModel}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(44);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      color: const Color(0xFF1E2124),
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
              label: 'addFraind',
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
    required this.label,
    required this.filter,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    final bool isActive = viewModel.selectedFilter == filter;
    return GestureDetector(
      onTap: () => viewModel.setFilter(filter),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.only(right: 6),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF5865F2) : const Color(0xFF2C2F33),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.white : const Color(0xFFB9BBBE),
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
