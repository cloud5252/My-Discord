// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:my_discord/models/messsage_model.dart';
import 'package:my_discord/ui/views/home/man_hub/chat/chat_view_model.dart';
import 'package:my_discord/ui/views/home/man_hub/chat/widget/hover_toolbar_widget.dart';
import 'package:my_discord/ui/views/home/man_hub/chat/widget/message_editing_field.dart';

class MessageBubbleWidget extends StatefulWidget {
  final MessageModel message;
  final ChatViewModel chatViewModel;
  const MessageBubbleWidget({
    Key? key,
    required this.message,
    required this.chatViewModel,
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

    return RepaintBoundary(
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: isEditing
                      ? const Color(0xFF5865F2).withOpacity(0.1)
                      : _isHovered
                          ? const Color(0xFF5865F2).withOpacity(0.2)
                          : Colors.transparent,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(4),
                    bottomRight: Radius.circular(4),
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: RepaintBoundary(
                    child: _buildMessageLayout(chatViewModel, isEditing),
                  ),
                ),
              ),
            ),

            // ← HOVER TOOLBAR
            if (_isHovered && !isEditing)
              Positioned(
                right: 30,
                top: 0,
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
            left: 24,
            top: 10,
            child: CustomPaint(
              size: const Size(36, 12),
              painter: _ReplyLinePainter(),
            ),
          ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const CircleAvatar(
              radius: 20,
              backgroundColor: Colors.blue,
              child: Icon(Icons.person, color: Colors.white),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.message.replyToMessageId != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(width: 8),
                          const CircleAvatar(
                            radius: 8,
                            backgroundColor: Color(0xFF313338),
                            child: Icon(Icons.person,
                                color: Colors.white, size: 10),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '@${widget.message.replyToSender ?? ""}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              widget.message.replyToText ?? '',
                              style: const TextStyle(
                                color: Color(0xFF80848E),
                                fontSize: 12,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          widget.message.senderEmail ?? "User",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
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
                  const SizedBox(height: 2),
                  if (isEditing)
                    MessageEditingField(chatViewModel: widget.chatViewModel)
                  else
                    _buildMessageText(),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMessageText() {
    return Row(
      children: [
        Expanded(
          child: Text(
            widget.message.messageText ?? "",
            style: const TextStyle(color: Color(0xFFDBDEE1), fontSize: 15),
          ),
        ),
        if (widget.message.isEdited == true)
          const Text(
            ' (edited)',
            style: TextStyle(
              color: Color(0xFF80848E),
              fontSize: 11,
              fontStyle: FontStyle.italic,
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
}

class _ReplyLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF4E5058)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    path.moveTo(size.width, 0);
    path.lineTo(8, 0);
    path.quadraticBezierTo(0, 0, 0, 8);
    path.lineTo(0, size.height);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
