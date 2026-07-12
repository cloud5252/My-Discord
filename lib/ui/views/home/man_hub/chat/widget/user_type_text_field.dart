import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChatInputField extends StatelessWidget {
  final TextEditingController controller;
  final String chatWithName;
  final VoidCallback onSend;
  final dynamic replyingTo;
  final VoidCallback? onCancelReply;
  final VoidCallback? onTapReplyPreview;

  const ChatInputField({
    Key? key,
    required this.controller,
    required this.chatWithName,
    required this.onSend,
    this.replyingTo,
    this.onCancelReply,
    this.onTapReplyPreview,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.enter): () {
          if (controller.text.trim().isNotEmpty) onSend();
        },
        const SingleActivator(LogicalKeyboardKey.enter, shift: true): () {
          final selection = controller.selection;
          final newText = controller.text
              .replaceRange(selection.start, selection.end, '\n');
          controller.value = TextEditingValue(
            text: newText,
            selection: TextSelection.collapsed(offset: selection.start + 1),
          );
        },
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF383A40),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (replyingTo != null)
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: onTapReplyPreview,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom:
                            BorderSide(color: Colors.grey.shade700, width: 0.5),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Replying to ${replyingTo.senderEmail ?? ""}',
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: onCancelReply,
                          child: const Icon(Icons.close,
                              color: Color(0xFF80848E), size: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            TextField(
              controller: controller,
              style: const TextStyle(color: Colors.white),
              cursorColor: Colors.white,
              autofocus: false,
              textAlignVertical: TextAlignVertical.center,
              maxLines: null,
              decoration: InputDecoration(
                hintText: 'Message @$chatWithName',
                hoverColor: Colors.transparent,
                hintStyle: const TextStyle(color: Color(0xFFd5d7de)),
                fillColor: Colors.transparent,
                filled: true,
                hintMaxLines: 1,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 20,
                ),
                prefixIcon:
                    const Icon(Icons.add_circle, color: Color(0xFFd5d7de)),
                suffixIcon: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.card_giftcard,
                        color: Color(0xFFd5d7de), size: 20),
                    SizedBox(width: 8),
                    Icon(Icons.gif_box_outlined,
                        color: Color(0xFFd5d7de), size: 20),
                    SizedBox(width: 8),
                    Icon(Icons.emoji_emotions_outlined,
                        color: Color(0xFFd5d7de), size: 20),
                    SizedBox(width: 12),
                  ],
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
