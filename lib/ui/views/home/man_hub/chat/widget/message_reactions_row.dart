// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:my_discord/models/messsage_model.dart';
import 'package:my_discord/ui/views/home/man_hub/chat/chat_view_model.dart';

class MessageReactionsRow extends StatelessWidget {
  final MessageModel message;
  final ChatViewModel chatViewModel;

  const MessageReactionsRow({
    Key? key,
    required this.message,
    required this.chatViewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final reactions = message.reactions;
    if (reactions.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Wrap(
        spacing: 6,
        runSpacing: 4,
        children: reactions.entries.map((entry) {
          final emoji = entry.key;
          final userIds = entry.value;
          final hasReacted = userIds.contains(chatViewModel.myUid);

          return GestureDetector(
            onTap: () => chatViewModel.toggleReaction(message, emoji),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: hasReacted
                    ? const Color(0xFF5865F2).withOpacity(0.16)
                    : const Color(0xFF2B2D31),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color:
                      hasReacted ? const Color(0xFF5865F2) : Colors.transparent,
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(emoji, style: const TextStyle(fontSize: 13)),
                  const SizedBox(width: 4),
                  Text(
                    userIds.length.toString(),
                    style: TextStyle(
                      color: hasReacted
                          ? const Color(0xFF5865F2)
                          : const Color(0xFFB5BAC1),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
