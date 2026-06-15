import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChatInputField extends StatelessWidget {
  final TextEditingController controller;
  final String chatWithName;
  final VoidCallback onSend;

  const ChatInputField({
    Key? key,
    required this.controller,
    required this.chatWithName,
    required this.onSend,
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
      child: TextField(
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
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          prefixIcon: const Icon(Icons.add_circle, color: Color(0xFFd5d7de)),
          suffixIcon: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.card_giftcard, color: Color(0xFFd5d7de), size: 20),
              SizedBox(width: 8),
              Icon(Icons.gif_box_outlined, color: Color(0xFFd5d7de), size: 20),
              SizedBox(width: 8),
              Icon(Icons.emoji_emotions_outlined,
                  color: Color(0xFFd5d7de), size: 20),
              SizedBox(width: 12),
            ],
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: Color(0xFF00A8FC), width: 0.3),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: Color(0xFF00A8FC), width: 0.8),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(
              color: Color(0xFF00A8FC),
              width: 2.0,
            ),
          ),
        ),
      ),
    );
  }
}
