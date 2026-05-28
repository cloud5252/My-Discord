import 'package:flutter/material.dart';
import 'package:my_discord/ui/views/home/man_hub/friends_hub/fraind_hub_view_model.dart';

class FilterTabStyle {
  static Color getBgColor({
    required FriendFilter filter,
    required bool isActive,
    required bool isHovered,
    required bool isPressed,
  }) {
    final bool isAddFriendTab = filter == FriendFilter.addfraind;

    if (isAddFriendTab) {
      if (isActive && isPressed) return const Color(0xFF3c4aa0);
      if (isActive) return const Color(0xFF232540);
      if (isHovered) return const Color(0xFF4E5DFF);
      return const Color(0xFF5a68ed);
    }

    if (isActive) return const Color(0xFF404249);
    if (isHovered) return const Color(0xFF35373C);
    return const Color(0xFF1a1a1e);
  }

  static Color getTextColor({
    required FriendFilter filter,
    required bool isActive,
    required bool isHovered,
  }) {
    final bool isAddFriendTab = filter == FriendFilter.addfraind;

    if (isAddFriendTab) {
      if (isActive) return const Color(0xFF6173e8);
      return Colors.white;
    }

    if (isActive) return Colors.white;
    if (isHovered) return const Color(0xFFDBDEE1);
    return const Color(0xFFB5BAC1);
  }
}
