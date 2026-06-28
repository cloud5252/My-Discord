// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:my_discord/ui/common/hover_builder.dart';
import 'package:my_discord/ui/views/home/man_hub/chat/context_manu/widget/tool_tip_context_manu.dart';

class HoverEmojiWidget extends StatelessWidget {
  final String emoji;
  final String tooltip;

  const HoverEmojiWidget({
    Key? key,
    required this.emoji,
    required this.tooltip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HoverBuilder(
      key: Key(emoji),
      builder: (isHovered) => InkWell(
        borderRadius: BorderRadius.circular(4),
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
            color: isHovered
                ? const Color(0xFFc6c5c1).withOpacity(0.2)
                : const Color(0xFFc6c5c1).withOpacity(0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: AnimatedScale(
              scale: isHovered ? 1.3 : 1.3,
              duration: const Duration(milliseconds: 80),
              child: Text(emoji, style: const TextStyle(fontSize: 18)),
            ),
          ),
        ),
      ).contextmanuTooltip(tooltip, showReact: true),
    );
  }
}
