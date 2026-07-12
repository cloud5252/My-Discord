// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:my_discord/models/messsage_model.dart';
import 'package:my_discord/ui/views/home/man_hub/chat/chat_view_model.dart';
import 'package:my_discord/ui/views/home/man_hub/chat/widget/hover_emoji_widget.dart';
import 'package:my_discord/ui/views/home/man_hub/chat/widget/hover_icon_widget.dart';
import 'package:my_discord/ui/views/home/man_hub/chat/context_manu/show_manu.dart';
import 'package:my_discord/ui/views/home/man_hub/chat/context_manu/ui_manu_item.dart';
import 'package:stacked/stacked.dart';

class HoverToolbarWidget extends StatefulWidget {
  final MessageModel message;

  const HoverToolbarWidget({
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
        color: const Color(0xFF242429).withOpacity(0.95),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: Colors.grey.shade800,
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
      child: SizedBox(
        height: 28,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            HoverEmojiWidget(
              emoji: '❤️',
              tooltip: 'Heart',
              onTap: () => chatViewModel.toggleReaction(widget.message, '❤️'),
            ),
            HoverEmojiWidget(
              emoji: '🔖',
              tooltip: 'Bookmark',
              onTap: () => chatViewModel.toggleReaction(widget.message, '🔖'),
            ),
            HoverEmojiWidget(
              emoji: '👍',
              tooltip: 'Thumbs Up',
              onTap: () => chatViewModel.toggleReaction(widget.message, '👍'),
            ),
            HoverEmojiWidget(
              emoji: '😊',
              tooltip: 'Smile',
              onTap: () => chatViewModel.toggleReaction(widget.message, '😊'),
            ),
            Container(
              width: 1,
              height: 15,
              margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              color: Colors.grey.shade500.withOpacity(0.5),
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
      ),
    );
  }

  void _showMoreOptions(BuildContext context, ChatViewModel chatViewModel) {
    final renderBox =
        _moreButtonKey.currentContext!.findRenderObject() as RenderBox;
    final buttonPosition = renderBox.localToGlobal(Offset.zero);
    final buttonSize = renderBox.size;

    const double leftShift = 40.0;
    const double topShift = -35.0;

    final menuPosition = Offset(
      buttonPosition.dx + buttonSize.width - leftShift,
      buttonPosition.dy + buttonSize.height + topShift,
    );

    DiscordContextMenu.show(
      context: context,
      position: menuPosition,
      messageId: widget.message.firebaseId ?? 'sdhkfhoiew9073434i34',
      onEmojiSelected: (emoji) {
        chatViewModel.insertEmojiIntoInput(emoji);
        DiscordContextMenu.hide();
      },
      items: [
        ContextMenuItem(
            label: 'Add Reaction',
            hasSubmenu: true,
            icon: Icons.arrow_back_ios_new,
            iconRotation: 3.14159,
            onTap: () {}
            // => chatViewModel.onReplyMessage(widget.message),
            ),
        ContextMenuItem.divider(),
        ContextMenuItem(
          label: 'Edit Message',
          icon: Icons.edit,
          iconRotation: 0.0,
          onTap: () => chatViewModel.startEditing(widget.message),
        ),
        ContextMenuItem(
          label: 'Reply',
          icon: Icons.reply,
          iconRotation: 0.0,
          onTap: () => chatViewModel.onReplyMessage(widget.message),
        ),
        ContextMenuItem(
          label: 'Forward',
          icon: Icons.reply,
          iconMirror: true,
          iconRotation: 3.14159,
          onTap: () => chatViewModel.onReplyMessage(widget.message),
        ),
        ContextMenuItem.divider(),
        ContextMenuItem(
          label: 'Copy Text',
          icon: Icons.copy,
          iconRotation: 0.0,
          onTap: () => chatViewModel.copyMessage(widget.message),
        ),
        ContextMenuItem(
          label: 'Pin Message',
          icon: Icons.push_pin,
          iconRotation: 0.785398,
          onTap: () => chatViewModel.showPinMessageDialog(widget.message),
        ),
        ContextMenuItem(
          label: 'Apps',
          icon: Icons.apps,
          iconRotation: 0.0,
          onTap: () => chatViewModel.onReplyMessage(widget.message),
        ),
        ContextMenuItem(
          label: 'Mark Unread',
          icon: Icons.mark_as_unread,
          iconRotation: 0.0,
          onTap: () => chatViewModel.onReplyMessage(widget.message),
        ),
        ContextMenuItem(
          label: 'Copy Message Link',
          icon: Icons.link,
          iconRotation: 0.0,
          onTap: () => chatViewModel.onReplyMessage(widget.message),
        ),
        ContextMenuItem(
          label: 'Speak Message',
          icon: Icons.volume_up,
          iconRotation: 0.0,
          onTap: () => chatViewModel.onReplyMessage(widget.message),
        ),
        ContextMenuItem.divider(),
        ContextMenuItem(
          label: 'Delete Message',
          icon: Icons.delete,
          iconRotation: 0.0,
          color: const Color(0xFFED4245),
          onTap: () => chatViewModel.deleteMessage(widget.message),
        ),
        ContextMenuItem(
          label: 'Copy Message ID',
          icon: Icons.numbers,
          iconRotation: 0.0,
          onTap: () => chatViewModel.deleteMessage(widget.message),
        ),
      ],
    );
  }
}
