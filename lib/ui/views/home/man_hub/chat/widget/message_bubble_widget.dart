// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:my_discord/models/messsage_model.dart';
import 'package:my_discord/ui/common/hover_builder.dart';
import 'package:my_discord/ui/views/home/man_hub/chat/chat_view_model.dart';
import 'package:my_discord/ui/views/home/man_hub/chat/widget/tool_tip_extention.dart';
import 'package:stacked/stacked.dart';

class MessageBubbleWidget extends StatelessWidget {
  final MessageModel message;

  const MessageBubbleWidget({Key? key, required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: HoverBuilder(
        key: Key(message.firebaseId.toString()),
        builder: (isHovered) => Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: ColoredBox(
                color: isHovered
                    ? const Color(0xFF5865F2).withOpacity(0.75)
                    : Colors.transparent,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: RepaintBoundary(
                    child: _buildMessageLayout(),
                  ),
                ),
              ),
            ),
            if (isHovered)
              Positioned(
                right: 30,
                top: 0,
                child: RepaintBoundary(
                  child: _buildHoverToolbar(context),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CircleAvatar(
          radius: 20,
          backgroundColor: Color(0xFF313338),
          child: Icon(Icons.person, color: Colors.white),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    message.senderEmail ?? "User",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _formatTimestamp(message.timestamp),
                    style: const TextStyle(
                      color: Color(0xFF80848E),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                message.messageText ?? "",
                style: const TextStyle(color: Color(0xFFDBDEE1), fontSize: 15),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _formatTimestamp(dynamic timestamp) {
    if (timestamp == null) return '';
    final dt =
        timestamp is DateTime ? timestamp : (timestamp as dynamic).toDate();
    final hour = dt.hour.toString().padLeft(2, '0');
    final min = dt.minute.toString().padLeft(2, '0');
    return 'Today at $hour:$min';
  }

  Widget _buildHoverToolbar(BuildContext context) {
    final chatViewModel = getParentViewModel<ChatViewModel>(context);

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1e1f7b).withOpacity(0.95),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: const Color(0xFF5865F2).withOpacity(0.4),
          width: 0.8,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            offset: const Offset(0, 2),
            blurRadius: 6,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const _HoverEmoji(emoji: '❤️', tooltip: 'Heart'),
          const _HoverEmoji(emoji: '🔖', tooltip: 'Bookmark'),
          const _HoverEmoji(emoji: '👍', tooltip: 'Thumbs Up'),
          const _HoverEmoji(emoji: '😊', tooltip: 'Smile'),
          Container(
            width: 1,
            height: 16,
            margin: const EdgeInsets.symmetric(vertical: 4),
            color: const Color(0xFF5865F2).withOpacity(0.4),
          ),
          _HoverIcon(
            icon: Icons.add_reaction_outlined,
            tooltip: 'Add Reaction',
            onTap: () {},
          ),
          _HoverIcon(
            icon: Icons.reply,
            tooltip: 'Reply',
            onTap: () => chatViewModel.onReplyMessage(message),
          ),
          _HoverIcon(
            icon: Icons.reply,
            tooltip: 'Forward',
            onTap: () {},
            isMirrored: true,
          ),
          _HoverIcon(
            icon: Icons.more_horiz,
            tooltip: 'More',
            onTap: () => chatViewModel.showOptions(message),
          ),
        ],
      ),
    );
  }
}

class _HoverEmoji extends StatelessWidget {
  final String emoji;
  final String tooltip;

  const _HoverEmoji({Key? key, required this.emoji, required this.tooltip})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HoverBuilder(
      key: Key(emoji),
      builder: (isHovered) => InkWell(
        borderRadius: BorderRadius.circular(4),
        onTap: () {},
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
          decoration: BoxDecoration(
            color: isHovered
                ? const Color(0xFFc6c5c1).withOpacity(0.15)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: AnimatedScale(
              scale: isHovered ? 1.4 : 1.3,
              duration: const Duration(milliseconds: 80),
              child: Text(emoji, style: const TextStyle(fontSize: 15)),
            ),
          ),
        ),
      ).discordTooltip(tooltip, showReact: true),
    );
  }
}

class _HoverIcon extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;
  final bool isMirrored;

  const _HoverIcon({
    Key? key,
    required this.icon,
    required this.tooltip,
    required this.onTap,
    this.isMirrored = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HoverBuilder(
      builder: (isHovered) => GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
          decoration: BoxDecoration(
            color: isHovered
                ? const Color(0xFFc6c5c1).withOpacity(0.15)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: AnimatedScale(
              scale: isHovered ? 1.4 : 1.3,
              duration: const Duration(milliseconds: 80),
              child: Transform(
                alignment: Alignment.center,
                transform: isMirrored
                    ? Matrix4.rotationY(3.14159)
                    : Matrix4.identity(),
                child: Icon(
                  icon,
                  size: 18,
                  color: isHovered ? Colors.white : const Color(0xFF8A8E94),
                ),
              ),
            ),
          ),
        ),
      ).discordTooltip(
        tooltip,
      ),
    );
  }
}
