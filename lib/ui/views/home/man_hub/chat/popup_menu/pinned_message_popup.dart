// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:my_discord/app/app.locator.dart';
import 'package:my_discord/models/messsage_model.dart';
import 'package:my_discord/ui/common/helper.dart';
import 'package:my_discord/ui/common/hover_builder.dart';
import 'package:my_discord/ui/views/home/man_hub/chat/chat_view_model.dart';

import '../../../../../dialogs/unpin_message/unpin_message_dialog_model.dart'
    show UnpinMessageDialogModel;

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
            minHeight: 170,
            maxHeight: MediaQuery.of(context).size.height * 0.95,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFF242429),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFF3A3C43), width: 1),
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
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SizedBox(height: 150);
                    }

                    final pinned = snapshot.data ?? [];

                    if (pinned.isEmpty) {
                      return const SizedBox(
                        height: 150,
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 24),
                            child: Text(
                              'No pinned messages yet.',
                              style: TextStyle(color: Color(0xFFB5BAC1)),
                            ),
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      itemCount: pinned.length,
                      itemBuilder: (context, index) {
                        final message = pinned[index];
                        return _PinnedMessageTile(
                            message: message,
                            chatViewModel: chatViewModel,
                            onJump: () {
                              onDismiss();
                              chatViewModel
                                  .scrollToMessage(message.firebaseId ?? '');
                            },
                            onDismiss: onDismiss);
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
  final ChatViewModel chatViewModel;
  final VoidCallback? onJump;
  final VoidCallback onDismiss;

  const _PinnedMessageTile({
    required this.message,
    required this.chatViewModel,
    required this.onDismiss,
    this.onJump,
  });

  @override
  Widget build(BuildContext context) {
    return HoverBuilder(
      builder: (isHovered) => Container(
        margin: const EdgeInsets.only(bottom: 8),
        // padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xFF2B2D31),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: const Color(0xFF3A3C43), width: 1),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 10.0, left: 8),
              child: CircleAvatar(
                radius: 16,
                backgroundColor: Colors.blue,
                child: Icon(Icons.person, color: Colors.white, size: 18),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            message.senderEmail ?? 'User',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          _formatTimestamp(message.timestamp),
                          style: const TextStyle(
                            color: Color(0xFF80848E),
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      message.messageText ?? '',
                      style: TextStyle(
                        color: const Color(0xFFDBDEE1),
                        fontSize: getMessageFontSize(message.messageText ?? ''),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            isHovered
                ? Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: _JumpButton(onTap: onJump),
                  )
                : const SizedBox.shrink(),
            const SizedBox(width: 6),
            isHovered
                ? Padding(
                    padding: const EdgeInsets.only(top: 6, right: 8),
                    child: _UnpinButton(
                      onTap: () async {
                        onDismiss();
                        final confirmed =
                            await locator<UnpinMessageDialogModel>()
                                .showUnpinMessageDialog(message);
                        if (confirmed) {
                          chatViewModel.unpinMessage(message);
                        }
                      },
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  String _formatTimestamp(DateTime? dt) {
    if (dt == null) return '';
    return '${dt.month}/${dt.day}/${dt.year.toString().substring(2)}, '
        '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }
}

class _JumpButton extends StatelessWidget {
  final VoidCallback? onTap;
  const _JumpButton({this.onTap});

  @override
  Widget build(BuildContext context) {
    return HoverBuilder(
      builder: (isHovered) => GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: isHovered
                ? const Color(0xFF505055).withOpacity(0.5)
                : const Color(0xFF35373C),
            borderRadius: BorderRadius.circular(6),
          ),
          child: const Padding(
            padding: EdgeInsets.all(2.0),
            child: Text(
              'Jump',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _UnpinButton extends StatelessWidget {
  final VoidCallback onTap;
  const _UnpinButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return HoverBuilder(
      builder: (isHovered) => GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: isHovered
                ? const Color(0xFF505055).withOpacity(0.5)
                : const Color(0xFF35373C),
            borderRadius: BorderRadius.circular(6),
          ),
          child: const Padding(
            padding: EdgeInsets.all(2.0),
            child: Icon(
              Icons.close,
              color: Color(0xFFB5BAC1),
              size: 16,
            ),
          ),
        ),
      ),
    );
  }
}
