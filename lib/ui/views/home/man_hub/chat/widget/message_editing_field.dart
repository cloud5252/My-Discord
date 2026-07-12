import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_discord/ui/views/home/man_hub/chat/chat_view_model.dart';

class MessageEditingField extends StatelessWidget {
  final ChatViewModel chatViewModel;

  const MessageEditingField({
    Key? key,
    required this.chatViewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF383A40),
            borderRadius: BorderRadius.circular(8),
          ),
          child: KeyboardListener(
            focusNode: FocusNode(),
            onKeyEvent: (event) {
              if (event.logicalKey == LogicalKeyboardKey.escape) {
                chatViewModel.cancelEditing();
              }
            },
            child: TextField(
              controller: chatViewModel.edittextController,
              style: const TextStyle(color: Colors.white, fontSize: 14),
              cursorColor: Colors.white,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                hoverColor: Colors.transparent,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:
                      const BorderSide(color: Color(0xFF4E5058), width: 0.5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:
                      const BorderSide(color: Color(0xFF4E5058), width: 1.8),
                ),
              ),
              onSubmitted: (_) => chatViewModel.sendOrEditMessage(),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            const Text('escape to ',
                style: TextStyle(color: Color(0xFF80848E), fontSize: 13)),
            _HoverText(
              text: 'cancel',
              onTap: () => chatViewModel.cancelEditing(),
            ),
            const Text(' • enter to ',
                style: TextStyle(color: Color(0xFF80848E), fontSize: 13)),
            _HoverText(
              text: 'save',
              onTap: () => chatViewModel.sendOrEditMessage(),
            ),
          ],
        ),
      ],
    );
  }
}

class _HoverText extends StatefulWidget {
  final String text;
  final VoidCallback onTap;

  const _HoverText({required this.text, required this.onTap});

  @override
  State<_HoverText> createState() => _HoverTextState();
}

class _HoverTextState extends State<_HoverText> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Text(
          widget.text,
          style: TextStyle(
            color: const Color(0xFF5865F2),
            fontSize: 14,
            decoration:
                _isHovered ? TextDecoration.underline : TextDecoration.none,
            decorationColor: const Color(0xFF5865F2),
            decorationThickness: 1.5,
          ),
        ),
      ),
    );
  }
}
