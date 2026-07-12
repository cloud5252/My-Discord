// ignore_for_file: deprecated_member_use

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
      if (isPressed) return const Color(0xFF3c4aa0);
      if (isHovered) return const Color(0xFF6675e3);
      return const Color(0xFF4E5DFF);
    }

    if (isPressed) return const Color(0xFF333338);
    if (isActive) return const Color(0xFF333338).withOpacity(0.55);
    if (isHovered) return const Color(0xFF333338).withOpacity(0.33);
    return const Color(0xFF121214).withOpacity(0.12);
  }

  static Color getTextColor({
    required FriendFilter filter,
    required bool isActive,
    required bool isHovered,
  }) {
    final bool isAddFriendTab = filter == FriendFilter.addfraind;

    if (isAddFriendTab) {
      if (isActive) return const Color(0xFFffffff);
      return Colors.white;
    }

    if (isActive) return Colors.white;
    if (isHovered) return const Color(0xFFDBDEE1);
    return const Color(0xFFB5BAC1);
  }
}
