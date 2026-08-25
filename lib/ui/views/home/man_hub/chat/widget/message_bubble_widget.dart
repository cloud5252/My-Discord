// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:my_discord/models/messsage_model.dart';
import 'package:my_discord/ui/views/home/man_hub/chat/chat_view_model.dart';
import 'package:my_discord/ui/views/home/man_hub/chat/widget/hover_toolbar_widget.dart';
import 'package:my_discord/ui/views/home/man_hub/chat/widget/message_editing_field.dart';
import 'package:my_discord/ui/views/home/man_hub/chat/widget/message_reactions_row.dart';

class MessageBubbleWidget extends StatefulWidget {
  final MessageModel message;
  final ChatViewModel chatViewModel;
  final bool showHeader;
  const MessageBubbleWidget({
    Key? key,
    required this.message,
    required this.chatViewModel,
    this.showHeader = true,
  }) : super(key: key);

  @override
  State<MessageBubbleWidget> createState() => _MessageBubbleWidgetState();
}

class _MessageBubbleWidgetState extends State<MessageBubbleWidget> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final chatViewModel = widget.chatViewModel;
    final isEditing =
        chatViewModel.editingMessage?.firebaseId == widget.message.firebaseId;

    final isBeingRepliedTo =
        chatViewModel.replyingTo?.firebaseId == widget.message.firebaseId;

    final isHighlighted =
        chatViewModel.highlightMessageId == widget.message.firebaseId;

    return RepaintBoundary(
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Container(
                decoration: BoxDecoration(
                  color: isHighlighted
                      ? const Color(0xFF5865F2).withOpacity(0.30)
                      : isBeingRepliedTo
                          ? const Color(0xFF5865F2).withOpacity(0.08)
                          : isEditing
                              ? const Color(0xFF262629)
                              : _isHovered
                                  ? const Color(0xFF262629)
                                  : const Color(0xFF1a1a1e),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(4),
                    bottomRight: Radius.circular(4),
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                  child: RepaintBoundary(
                    child: _buildMessageLayout(chatViewModel, isEditing),
                  ),
                ),
              ),
            ),
            if (_isHovered && !isEditing)
              Positioned(
                right: 15,
                top: 5,
                child: RepaintBoundary(
                  child: HoverToolbarWidget(
                    message: widget.message,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageLayout(ChatViewModel chatViewModel, bool isEditing) {
    return Stack(
      children: [
        if (widget.message.replyToMessageId != null)
          Positioned(
            left: 20,
            top: 10,
            child: ReplyLineIndicator(
              onTap: () {
                chatViewModel.scrollToMessage(widget.message.replyToMessageId!);
              },
            ),
          ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: isEditing
                    ? 23
                    : (widget.message.replyToMessageId != null)
                        ? 23
                        : 1.5,
              ),
              child: widget.showHeader
                  ? const CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.blue,
                      child: Icon(Icons.person, color: Colors.white),
                    )
                  : const SizedBox(width: 40),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.showHeader &&
                      widget.message.replyToMessageId != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: Row(
                        children: [
                          Flexible(
                            child: Text.rich(
                              TextSpan(
                                children: [
                                   
                                  // TextSpan(
                                  //   text:
                                  //       '${widget.message.replyToSender ?? "Someone"}  ',
                                  //   style: const TextStyle(
                                  //     color: Color(0xFFDBDEE1),
                                  //     fontWeight: FontWeight.bold,
                                  //     fontStyle: FontStyle.italic,
                                  //     fontSize: 13,
                                  //   ),
                                  // ),
                                  TextSpan(
                                    text: widget.message.replyToText ?? "",
                                    style: const TextStyle(
                                      color: Color(0xFF80848E),
                                      fontStyle: FontStyle.italic,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (widget.showHeader)
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            widget.message.senderEmail ?? "User",
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            _formatTimestamp(widget.message.timestamp),
                            style: const TextStyle(
                                color: Color(0xFF80848E), fontSize: 11),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  if (widget.showHeader) const SizedBox(height: 5),
                  if (isEditing)
                    MessageEditingField(chatViewModel: widget.chatViewModel)
                  else
                    _buildMessageText(),
                  MessageReactionsRow(
                    message: widget.message,
                    chatViewModel: widget.chatViewModel,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMessageText() {
    final text = widget.message.messageText ?? "";
    final fontSize = _getMessageFontSize(text);

    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: text,
            style: TextStyle(
              color: const Color(0xFFDBDEE1),
              fontSize: fontSize,
            ),
          ),
          if (widget.message.isEdited == true)
            const TextSpan(
              text: '   (edited)',
              style: TextStyle(
                color: Color(0xFF80848E),
                fontSize: 11,
                fontStyle: FontStyle.italic,
              ),
            ),
        ],
      ),
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
}

class ReplyLineIndicator extends StatefulWidget {
  final VoidCallback onTap;

  const ReplyLineIndicator({Key? key, required this.onTap}) : super(key: key);

  @override
  State<ReplyLineIndicator> createState() => _ReplyLineIndicatorState();
}

class _ReplyLineIndicatorState extends State<ReplyLineIndicator> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: widget.onTap,
        child: CustomPaint(
          size: const Size(30, 10),
          painter: _ReplyLinePainter(isHovered: _isHovered),
        ),
      ),
    );
  }
}

class _ReplyLinePainter extends CustomPainter {
  final bool isHovered;

  _ReplyLinePainter({this.isHovered = false});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isHovered ? const Color(0xFFDBDEE1) : const Color(0xFF4E5058)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    path.moveTo(size.width, 0);
    path.lineTo(5, 0);
    path.quadraticBezierTo(0, 0, 0, 8);
    path.lineTo(0, size.height);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _ReplyLinePainter oldDelegate) =>
      oldDelegate.isHovered != isHovered;
}

bool _isOnlyEmojis(String text) {
  final emojiRegex = RegExp(
    r'^(\s|[\u{1F300}-\u{1FAFF}]|[\u{2600}-\u{27BF}]|[\u{1F1E6}-\u{1F1FF}]|[\u{2000}-\u{206F}]|\uFE0F)+$',
    unicode: true,
  );
  return emojiRegex.hasMatch(text.trim()) && text.trim().isNotEmpty;
}

double _getMessageFontSize(String text) {
  final trimmed = text.trim();
  if (_isOnlyEmojis(trimmed)) {
    final emojiCount = trimmed.runes.length;
    if (emojiCount <= 8) return 40;
  }
  return 15;
}
