import 'package:flutter/material.dart';
import 'package:my_discord/service/chat_service/viewService.dart';
import 'package:my_discord/ui/common/discord_tool_tip_extension.dart';
import 'package:my_discord/ui/common/hover_builder.dart';
import 'package:my_discord/ui/views/home/man_hub/chat/chat_view_model.dart';
import 'package:my_discord/ui/views/home/man_hub/chat/popup_menu/pinned_message_controller.dart';
import 'package:stacked/stacked.dart';

class ChatTopHeader extends StatelessWidget implements PreferredSizeWidget {
  final String chatWithName;
  final ViewService viewService;
  const ChatTopHeader(
      {Key? key, required this.chatWithName, required this.viewService})
      : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(48);

  @override
  Widget build(BuildContext context) {
    final GlobalKey pinButtonKey = GlobalKey();
    final chatViewModel = getParentViewModel<ChatViewModel>(context);
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade700,
            width: 0.2,
          ),
          top: BorderSide(
            color: Colors.grey.shade700,
            width: 0.2,
          ),
          left: BorderSide(
            color: Colors.grey.shade700,
            width: 0.2,
          ),
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isNarrow = constraints.maxWidth < 500;
          // final showSearch = searchMaxWidth > 30;
          return Row(
            children: [
              Expanded(
                child: Text(
                  chatWithName,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
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
                key: pinButtonKey,
                icon: Icons.push_pin,
                tooltip: 'Pinned Messages',
                onTap: () {
                  final renderBox = pinButtonKey.currentContext!
                      .findRenderObject() as RenderBox;
                  final position = renderBox.localToGlobal(Offset.zero);
                  final size = renderBox.size;

                  PinnedMessagesController.show(
                    context,
                    Offset(position.dx, position.dy + size.height + 8),
                    chatViewModel,
                  );
                },
                rotate: true,
              ),
              _HeaderIcon(
                icon: Icons.person_add_alt_1,
                tooltip: 'Add Friends to DM',
                onTap: () {},
              ),
              _HeaderIcon(
                icon: Icons.account_circle,
                tooltip: 'User Profile Toggle',
                onTap: () => viewService.toggleProfile(),
              ),
              const SizedBox(width: 8),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: isNarrow ? 80 : 280,
                  minWidth: 80,
                ),
                child: _SearchBar(),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _HeaderIcon extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;
  final bool rotate;

  const _HeaderIcon({
    Key? key,
    required this.icon,
    required this.tooltip,
    required this.onTap,
    this.rotate = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HoverBuilder(
      builder: (isHovered) => GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0),
          child: SizedBox(
            width: 32,
            height: 32,
            child: Center(
              child: rotate
                  ? Transform.rotate(
                      angle: 0.7,
                      child: Icon(
                        icon,
                        color:
                            isHovered ? Colors.white : const Color(0xFFB5BAC1),
                        size: 20,
                      ),
                    )
                  : Icon(
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

class _SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 35,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.grey.shade500,
          width: 1,
        ),
      ),
      child: const Row(
        children: [
          Expanded(
            child: TextField(
              cursorWidth: 0.9,
              cursorColor: Colors.white,
              style: TextStyle(color: Colors.white, fontSize: 12),
              decoration: InputDecoration(
                hintText: 'Search',
                hintMaxLines: 1,
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
    );
  }
}
