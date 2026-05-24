// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:my_discord/models/messsage_model.dart';
import 'package:my_discord/ui/common/discord_tool_tip_extension.dart';
import 'package:my_discord/ui/views/home/man_hub/chat/chat_view_model.dart';
import 'package:stacked/stacked.dart';

class MessageBubbleWidget extends StatelessWidget {
  final MessageModel message;
  final _hovered = ValueNotifier<bool>(false);

  MessageBubbleWidget({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _hovered.value = true,
      onExit: (_) => _hovered.value = false,
      child: ValueListenableBuilder<bool>(
        valueListenable: _hovered,
        builder: (context, isHovered, child) => Container(
          decoration: BoxDecoration(
            color: isHovered ? const Color(0xFF2E3035) : Colors.transparent,
          ),
          margin: const EdgeInsets.only(right: 20),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              child!,
              if (isHovered)
                Positioned(
                  top: -20,
                  right: 0,
                  child: _buildHoverToolbar(context),
                ),
            ],
          ),
        ),
        child: _buildMessageLayout(),
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
    final dt = timestamp.toDate();
    final hour = dt.hour.toString().padLeft(2, '0');
    final min = dt.minute.toString().padLeft(2, '0');
    return 'Today at $hour:$min';
  }

  Widget _buildHoverToolbar(BuildContext context) {
    final chatViewModel = getParentViewModel<ChatViewModel>(context);

    return ViewModelBuilder<_HoverViewModel>.reactive(
      viewModelBuilder: () => _HoverViewModel(),
      builder: (context, model, child) => MouseRegion(
        onEnter: (_) => model.setHover(true),
        onExit: (_) => model.setHover(false),
        hitTestBehavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          decoration: BoxDecoration(
            color: const Color(0xFF2B2D31),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: model.isHovered
                  ? const Color(0xFF404249)
                  : const Color(0xFF1E1F22),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(model.isHovered ? 0.6 : 0.3),
                blurRadius: model.isHovered ? 12 : 4,
                offset: Offset(0, model.isHovered ? 4 : 2),
              ),
            ],
          ),
          child: IntrinsicHeight(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _HoverEmoji(emoji: '❤️', tooltip: 'Heart'),
                _HoverEmoji(emoji: '🔖', tooltip: 'Bookmark'),
                _HoverEmoji(emoji: '👍', tooltip: 'Thumbs Up'),
                _HoverEmoji(emoji: '😊', tooltip: 'Smile'),
                Container(
                  width: 1,
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  color: const Color(0xFF1E1F22),
                ),
                _HoverIcon(
                    icon: Icons.add_reaction_outlined,
                    tooltip: 'Add Reaction',
                    onTap: () {}),
                _HoverIcon(
                    icon: Icons.reply,
                    tooltip: 'Reply',
                    onTap: () => chatViewModel.onReplyMessage(message)),
                _HoverIcon(
                    icon: Icons.reply,
                    tooltip: 'Forward',
                    onTap: () {},
                    isMirrored: true),
                _HoverIcon(
                    icon: Icons.more_horiz,
                    tooltip: 'More',
                    onTap: () => chatViewModel.showOptions(message)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HoverEmoji extends StatelessWidget {
  final String emoji;
  final String tooltip;
  final _hovered = ValueNotifier<bool>(false);

  _HoverEmoji({required this.emoji, required this.tooltip});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _hovered.value = true,
      onExit: (_) => _hovered.value = false,
      child: ValueListenableBuilder<bool>(
        valueListenable: _hovered,
        builder: (context, isHovered, child) => InkWell(
          borderRadius: BorderRadius.circular(4),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: AnimatedScale(
              scale: isHovered ? 1.3 : 1.0,
              duration: const Duration(milliseconds: 100),
              child: Text(emoji, style: const TextStyle(fontSize: 15)),
            ),
          ),
        ).withDiscordTooltip(tooltip),
      ),
    );
  }
}

class _HoverIcon extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;
  final bool isMirrored;
  final _hovered = ValueNotifier<bool>(false);

  _HoverIcon({
    required this.icon,
    required this.tooltip,
    required this.onTap,
    this.isMirrored = false,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _hovered.value = true,
      onExit: (_) => _hovered.value = false,
      child: ValueListenableBuilder<bool>(
        valueListenable: _hovered,
        builder: (context, isHovered, child) => GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(7),
            child: AnimatedScale(
              scale: isHovered ? 1.25 : 1.0,
              duration: const Duration(milliseconds: 100),
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
        ).withDiscordTooltip(tooltip),
      ),
    );
  }
}

class _HoverViewModel extends BaseViewModel {
  bool _isHovered = false;
  bool get isHovered => _isHovered;
  void setHover(bool value) {
    _isHovered = value;
    notifyListeners();
  }
}
