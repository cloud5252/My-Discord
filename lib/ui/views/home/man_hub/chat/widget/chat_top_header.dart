import 'package:flutter/material.dart';
import 'package:my_discord/ui/common/discord_tool_tip_extension.dart';
import 'package:my_discord/ui/common/hover_builder.dart';

class ChatTopHeader extends StatelessWidget implements PreferredSizeWidget {
  final String chatWithName;

  const ChatTopHeader({Key? key, required this.chatWithName}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(48);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: Color(0xFF1a1a1e),
        border: Border(
          bottom: BorderSide(color: Color(0xFF202225), width: 1),
        ),
      ),
      child: Row(
        children: [
          // @ symbol
          const Text('@',
              style: TextStyle(color: Color(0xFF80848E), fontSize: 18)),
          const SizedBox(width: 6),
          Text(
            chatWithName,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          const Spacer(),

          // ✅ Custom header icons
          _HeaderIcon(
            icon: Icons.phone_in_talk,
            tooltip: 'Start Voice Call',
            onTap: () {},
          ),
          _HeaderIcon(
            icon: Icons.videocam,
            tooltip: 'Start Video Call',
            onTap: () {},
          ),
          _HeaderIcon(
            icon: Icons.push_pin,
            tooltip: 'Pinned Messages',
            onTap: () {},
          ),
          _HeaderIcon(
            icon: Icons.person_add,
            tooltip: 'Add Friends to DM',
            onTap: () {},
          ),
          _HeaderIcon(
            icon: Icons.account_circle,
            tooltip: 'User Profile Toggle',
            onTap: () {},
          ),

          const SizedBox(width: 8),

          _SearchBar(),
        ],
      ),
    );
  }
}

class _HeaderIcon extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;

  const _HeaderIcon({
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
          child: Center(
            child: Icon(
              icon,
              color: isHovered ? Colors.white : const Color(0xFFB5BAC1),
              size: 20,
            ),
          ),
        ),
      ),
    ).withDiscordTooltip(tooltip, preferBelow: true);
  }
}

class _SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HoverBuilder(
      builder: (isHovered) => Container(
        width: 144,
        height: 24,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: isHovered ? const Color(0xFF2B2D31) : const Color(0xFF1e1f22),
          borderRadius: BorderRadius.circular(4),
        ),
        child: const Row(
          children: [
            Expanded(
              child: TextField(
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.white, fontSize: 12),
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Color(0xFF949BA4), fontSize: 12),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
            Icon(Icons.search, color: Color(0xFF949BA4), size: 16),
          ],
        ),
      ),
    );
  }
}
