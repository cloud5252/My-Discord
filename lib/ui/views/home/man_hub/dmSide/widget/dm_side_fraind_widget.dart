// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:my_discord/models/hive_user_model.dart';
import 'package:my_discord/ui/views/home/man_hub/dmSide/dm_side_view_model.dart';
import 'package:my_discord/ui/common/hover_builder.dart';
import 'package:my_discord/ui/common/press_builder.dart';
import 'package:stacked/stacked.dart';

class DmSideFraindWidget extends ViewModelWidget<DmSideViewModel> {
  const DmSideFraindWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, DmSideViewModel viewModel) {
    final box = Hive.box<HiveUserModel>('friends_box');

    return StreamBuilder<BoxEvent>(
      stream: box.watch(),
      builder: (context, snapshot) {
        final friends = box.values.toList();

        if (viewModel.isBusy && friends.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: CircularProgressIndicator(
                  color: Colors.white, strokeWidth: 2),
            ),
          );
        }

        if (friends.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                'No friends yet.',
                style: TextStyle(color: Color(0xFFB5BAC1), fontSize: 13),
              ),
            ),
          );
        }

        return ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: viewModel.friends.length,
          itemBuilder: (context, index) {
            final friend = viewModel.friends[index];
            return _buildFriendTile(friend, viewModel);
          },
        );
      },
    );
  }

  Widget _buildFriendTile(HiveUserModel friend, DmSideViewModel viewModel) {
    bool isOnline = friend.status == 'online';
    final String id = friend.uid;
    final bool isActive = viewModel.currentChatId == id;

    return HoverBuilder(
      builder: (isHovered) => PressBuilder(
        onTap: () => viewModel.navigateToChat(friend),
        builder: (isPressed) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: isPressed
                ? const Color(0xFF7585ff).withOpacity(0.33)
                : isActive
                    ? const Color(0xFF5865F2).withOpacity(0.3)
                    : isHovered
                        ? const Color(0xFF5865F2).withOpacity(0.15)
                        : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Row(
              children: [
                Stack(
                  children: [
                    const CircleAvatar(
                      radius: 16,
                      backgroundColor: Color(0xFF5865F2),
                      child: Icon(Icons.person, color: Colors.white, size: 18),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: isOnline ? Colors.green : Colors.grey,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFF2B2D31),
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    friend.displayName, // Direct String value from Model
                    style: TextStyle(
                      color: isActive || isHovered || isPressed
                          ? Colors.white
                          : const Color(0xFF96979e),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
