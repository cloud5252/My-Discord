// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:my_discord/models/messsage_model.dart';
import 'package:my_discord/ui/views/home/man_hub/chat/chat_view_model.dart';

class PinnedMessagesPopup extends StatelessWidget {
  final Offset position;
  final ChatViewModel chatViewModel;
  final VoidCallback onDismiss;

  const PinnedMessagesPopup({
    Key? key,
    required this.position,
    required this.chatViewModel,
    required this.onDismiss,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 300,
      top: position.dy,
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: 380,
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.6,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFF2B2D31),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Transform.rotate(
                      angle: 0.7,
                      child: const Icon(Icons.push_pin,
                          color: Colors.white, size: 20),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Pinned Messages',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: StreamBuilder<List<MessageModel>>(
                  stream: chatViewModel.pinnedMessagesStream,
                  builder: (context, snapshot) {
                    final pinned = snapshot.data ?? [];

                    if (pinned.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.only(bottom: 24),
                        child: Text(
                          'No pinned messages yet.',
                          style: TextStyle(color: Color(0xFFB5BAC1)),
                        ),
                      );
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      itemCount: pinned.length,
                      itemBuilder: (context, index) {
                        final message = pinned[index];
                        return _PinnedMessageTile(message: message);
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}

class _PinnedMessageTile extends StatelessWidget {
  final MessageModel message;

  const _PinnedMessageTile({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF232428),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            radius: 16,
            backgroundColor: Colors.blue,
            child: Icon(Icons.person, color: Colors.white, size: 18),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      message.senderEmail ?? 'User',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(width: 6),
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
                  message.messageText ?? '',
                  style: const TextStyle(
                    color: Color(0xFFDBDEE1),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatTimestamp(DateTime? dt) {
    if (dt == null) return '';
    return '${dt.month}/${dt.day}/${dt.year.toString().substring(2)}, '
        '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }
}
