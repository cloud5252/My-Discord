// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:my_discord/models/messsage_model.dart';
import 'package:my_discord/ui/common/discord_tool_tip_extension.dart';
import 'package:my_discord/ui/views/home/center%20panels/chat/chat_view_model.dart';
import 'package:stacked/stacked.dart';

class MessageBubbleWidget extends StatelessWidget {
  final MessageModel message;

  const MessageBubbleWidget({Key? key, required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<_HoverViewModel>.reactive(
      viewModelBuilder: () => _HoverViewModel(),
      builder: (context, model, child) => MouseRegion(
        onEnter: (_) => model.setHover(true),
        onExit: (_) => model.setHover(false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 80),
          decoration: BoxDecoration(
            color:
                model.isHovered ? const Color(0xFF2E3035) : Colors.transparent,
          ),
          margin: const EdgeInsets.only(right: 20),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              _buildMessageLayout(),
              if (model.isHovered)
                Positioned(
                  top: -20,
                  right: 0,
                  child: _buildHoverToolbar(context),
                ),
            ],
          ),
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
                    message.senderEmail?.split('@')[0] ?? "User",
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "Today at 1:53 AM",
                    style: TextStyle(color: Colors.grey[500], fontSize: 11),
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

  Widget _buildHoverToolbar(BuildContext context) {
    final chatViewModel = getParentViewModel<ChatViewModel>(context);

    return ViewModelBuilder<ToolbarViewModel>.reactive(
      viewModelBuilder: () => ToolbarViewModel(),
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
              color: model.isToolbarHovered
                  ? const Color(0xFF404249)
                  : const Color(0xFF1E1F22),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black
                    .withOpacity(model.isToolbarHovered ? 0.6 : 0.3),
                blurRadius: model.isToolbarHovered ? 12 : 4,
                offset: Offset(0, model.isToolbarHovered ? 4 : 2),
              ),
            ],
          ),
          child: IntrinsicHeight(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const _HoverEmoji(emoji: '❤️', tooltip: 'Heart'),
                const _HoverEmoji(emoji: '🔖', tooltip: 'Bookmark'),
                const _HoverEmoji(emoji: '👍', tooltip: 'Thumbs Up'),
                const _HoverEmoji(emoji: '😊', tooltip: 'Smile'),
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

class _HoverIcon extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;
  final bool isMirrored;

  const _HoverIcon({
    required this.icon,
    required this.tooltip,
    required this.onTap,
    this.isMirrored = false,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<_HoverViewModel>.reactive(
      viewModelBuilder: () => _HoverViewModel(),
      builder: (context, model, child) => MouseRegion(
        onEnter: (_) => model.setHover(true),
        onExit: (_) => model.setHover(false),
        child: GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(7),
            child: AnimatedScale(
              scale: model.isHovered ? 1.25 : 1.0,
              duration: const Duration(milliseconds: 150),
              child: Transform(
                alignment: Alignment.center,
                transform: isMirrored
                    ? Matrix4.rotationY(3.14159)
                    : Matrix4.identity(),
                child: Icon(
                  icon,
                  size: 18,
                  color:
                      model.isHovered ? Colors.white : const Color(0xFF8A8E94),
                ),
              ),
            ),
          ),
        ).withDiscordTooltip(tooltip),
      ),
    );
  }
}

class _HoverEmoji extends StatelessWidget {
  final String emoji;
  final String tooltip;

  const _HoverEmoji({required this.emoji, required this.tooltip});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<_HoverViewModel>.reactive(
      viewModelBuilder: () => _HoverViewModel(),
      builder: (context, model, child) => MouseRegion(
        onEnter: (_) => model.setHover(true),
        onExit: (_) => model.setHover(false),
        child: InkWell(
          borderRadius: BorderRadius.circular(4),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: AnimatedScale(
              scale: model.isHovered ? 1.3 : 1.0,
              duration: const Duration(milliseconds: 150),
              child: Text(emoji, style: const TextStyle(fontSize: 15)),
            ),
          ),
        ).withDiscordTooltip(tooltip),
      ),
    );
  }
}

class ToolbarViewModel extends BaseViewModel {
  bool _isToolbarHovered = false;
  bool get isToolbarHovered => _isToolbarHovered;
  void setHover(bool value) {
    _isToolbarHovered = value;
    notifyListeners();
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
