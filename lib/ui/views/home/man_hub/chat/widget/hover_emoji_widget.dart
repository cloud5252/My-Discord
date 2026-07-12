// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:my_discord/ui/common/hover_builder.dart';
import 'package:my_discord/ui/views/home/man_hub/chat/widget/tool_tip_extention.dart';

class HoverEmojiWidget extends StatelessWidget {
  final String emoji;
  final String tooltip;
  final VoidCallback onTap;

  const HoverEmojiWidget({
    Key? key,
    required this.emoji,
    required this.tooltip,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HoverBuilder(
      key: Key(emoji),
      builder: (isHovered) => InkWell(
        borderRadius: BorderRadius.circular(4),
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
          decoration: BoxDecoration(
            color: isHovered
                ? const Color(0xFFc6c5c1).withOpacity(0.15)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: AnimatedScale(
              scale: isHovered ? 1.4 : 1.3,
              duration: const Duration(milliseconds: 80),
              child: SizedBox(
                height: 15,
                width: 15,
                child: Center(
                  child: Text(
                    emoji,
                    style: const TextStyle(
                      fontSize: 12,
                      height: 1.0,
                    ),
                    strutStyle: const StrutStyle(
                      height: 1.0,
                      forceStrutHeight: true,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ).discordTooltip(tooltip, showReact: true),
    );
  }
}
