// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:my_discord/models/messsage_model.dart';
import 'package:my_discord/ui/views/home/man_hub/chat/chat_view_model.dart';
import 'package:my_discord/ui/views/home/man_hub/chat/widget/hover_emoji_widget.dart';
import 'package:my_discord/ui/views/home/man_hub/chat/widget/hover_icon_widget.dart';
import 'package:my_discord/ui/views/home/man_hub/chat/widget/popup_manu/show_manu.dart';
import 'package:my_discord/ui/views/home/man_hub/chat/widget/popup_manu/ui_manu_item.dart';
import 'package:stacked/stacked.dart';

class HoverToolbarWidget extends StatefulWidget {
  final MessageModel message;

  HoverToolbarWidget({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  State<HoverToolbarWidget> createState() => _HoverToolbarWidgetState();
}

class _HoverToolbarWidgetState extends State<HoverToolbarWidget> {
  final GlobalKey _moreButtonKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
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
          const HoverEmojiWidget(emoji: '❤️', tooltip: 'Heart'),
          const HoverEmojiWidget(emoji: '🔖', tooltip: 'Bookmark'),
          const HoverEmojiWidget(emoji: '👍', tooltip: 'Thumbs Up'),
          const HoverEmojiWidget(emoji: '😊', tooltip: 'Smile'),
          Container(
            width: 1,
            height: 16,
            margin: const EdgeInsets.symmetric(vertical: 4),
            color: const Color(0xFF5865F2).withOpacity(0.4),
          ),
          HoverIconWidget(
            icon: Icons.add_reaction_outlined,
            tooltip: 'Add Reaction',
            onTap: () {},
          ),
          HoverIconWidget(
            icon: Icons.reply,
            tooltip: 'Reply',
            onTap: () => chatViewModel.onReplyMessage(widget.message),
          ),
          HoverIconWidget(
            icon: Icons.reply,
            tooltip: 'Forward',
            onTap: () {},
            isMirrored: true,
          ),
          HoverIconWidget(
            key: _moreButtonKey,
            icon: Icons.more_horiz,
            tooltip: 'More',
            onTap: () => _showMoreOptions(context, chatViewModel),
          ),
        ],
      ),
    );
  }

  void _showMoreOptions(BuildContext context, ChatViewModel chatViewModel) {
    final renderBox =
        _moreButtonKey.currentContext!.findRenderObject() as RenderBox;
    final buttonPosition = renderBox.localToGlobal(Offset.zero);
    final buttonSize = renderBox.size;

    const double leftShift = 40.0;
    const double topShift = -40.0;

    final menuPosition = Offset(
      buttonPosition.dx + buttonSize.width - leftShift,
      buttonPosition.dy + buttonSize.height + topShift,
    );

    DiscordContextMenu.show(
      context: context,
      position: menuPosition,
      items: [
        ContextMenuItem(
          label: 'Add Reaction',
          icon: Icons.add_reaction_outlined,
          onTap: () => chatViewModel.onReplyMessage(widget.message),
        ),
        ContextMenuItem(
          label: 'Edit Message',
          icon: Icons.add_reaction_outlined,
          onTap: () => chatViewModel.onReplyMessage(widget.message),
        ),
        ContextMenuItem(
          label: 'Reply',
          icon: Icons.add_reaction_outlined,
          onTap: () => chatViewModel.onReplyMessage(widget.message),
        ),
        ContextMenuItem(
          label: 'Forword',
          icon: Icons.add_reaction_outlined,
          onTap: () => chatViewModel.onReplyMessage(widget.message),
        ),
        ContextMenuItem(
          label: 'Copy Text',
          icon: Icons.copy,
          onTap: () => chatViewModel.copyMessage(widget.message),
        ),
        ContextMenuItem(
          label: 'Pin Message',
          icon: Icons.reply,
          onTap: () => chatViewModel.onReplyMessage(widget.message),
        ),
        ContextMenuItem(
          label: 'Apps',
          icon: Icons.reply,
          onTap: () => chatViewModel.onReplyMessage(widget.message),
        ),
        ContextMenuItem(
          label: 'Mark Unread',
          icon: Icons.reply,
          onTap: () => chatViewModel.onReplyMessage(widget.message),
        ),
        ContextMenuItem(
          label: 'Copy Message Link',
          icon: Icons.reply,
          onTap: () => chatViewModel.onReplyMessage(widget.message),
        ),
        ContextMenuItem(
          label: 'Speak Message',
          icon: Icons.reply,
          onTap: () => chatViewModel.onReplyMessage(widget.message),
        ),
        ContextMenuItem.divider(),
        ContextMenuItem(
          label: 'Delete Message',
          icon: Icons.delete_outline,
          color: const Color(0xFFED4245),
          onTap: () => chatViewModel.deleteMessage(widget.message),
        ),
        ContextMenuItem(
          label: 'Copy Message ID',
          icon: Icons.delete_outline,
          color: const Color(0xFFED4245),
          onTap: () => chatViewModel.deleteMessage(widget.message),
        ),
      ],
    );
  }
}
