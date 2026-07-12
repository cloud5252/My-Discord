// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:my_discord/ui/common/discord_tool_tip_extension.dart';
import 'package:my_discord/ui/common/hover_builder.dart';
import 'package:my_discord/ui/views/home/man_hub/dmSide/dm_side_view.dart';
import 'package:my_discord/ui/views/home/home_viewmodel.dart';
import 'package:my_discord/ui/views/home/man_hub/friends_hub/fraind_hub_view.dart';
import 'package:my_discord/ui/views/home/widget/server_sidebar/server_sidebar_view.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(BuildContext context, HomeViewModel viewModel, Widget? child) {
    final width = MediaQuery.of(context).size.width;

    viewModel.updateScreenWidth(width);
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _FriendHeaderIcon(
                    icon: Icons.inbox, tooltip: 'New group DM', onTap: () {}),
                const SizedBox(width: 10),
                _FriendHeaderIcon(
                    icon: Icons.help_outline, tooltip: 'Help', onTap: () {})
              ],
            ),
          )
        ],
        centerTitle: true,
        backgroundColor: const Color(0xFF121214),
        toolbarHeight: 33,
        automaticallyImplyLeading: false,
        titleSpacing: 16,
        title: _tabtag(title: viewModel.appBarTitle),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: const Color(0xFF1E1F22), height: 1.5),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(color: Color(0XFF121214)
            // gradient: LinearGradient(
            //   begin: Alignment.topLeft,
            //   end: Alignment.bottomRight,
            //   colors: [
            //     Color(0xFF1e1f7b),
            //     Color(0xFF1a1b2e),
            //   ],
            //   stops: [
            //     0.0,
            //     0.8,
            //   ],
            // ),
            ),
        child: Row(
          children: [
            const SizedBox(width: 50, child: ServerSidebar()),
            const SizedBox(width: 270, child: DmSideView()),
            Expanded(
              child: viewModel.currentView is SizedBox
                  ? const FraindHubView()
                  : viewModel.currentView,
            ),
          ],
        ),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}

class _tabtag extends StatelessWidget {
  final String title;
  const _tabtag({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildIconForTitle(title),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildIconForTitle(String title) {
    if (title == "Friends") {
      return const Icon(Icons.people_alt, color: Color(0xFF80848E), size: 20);
    } else if (title == "Nitro") {
      return const Icon(Icons.bolt, color: Color(0xFF80848E), size: 20);
    } else if (title == "Shop") {
      return const Icon(Icons.shopping_bag, color: Color(0xFF80848E), size: 20);
    } else if (title == "Quests") {
      return const Icon(Icons.checklist_outlined,
          color: Color(0xFF80848E), size: 20);
    } else {
      return const Text('');
    }
  }
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
          // margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: isHovered ? const Color(0xFF35373C) : Colors.transparent,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: AnimatedScale(
              scale: 1.0, // isHovered ? 1.15 : 1.0,
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
