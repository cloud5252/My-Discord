// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:my_discord/ui/common/hover_builder.dart';
import 'package:my_discord/ui/views/home/man_hub/chat/widget/tool_tip_extention.dart';

class HoverIconWidget extends StatefulWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;
  final bool isMirrored;

  const HoverIconWidget({
    Key? key,
    required this.icon,
    required this.tooltip,
    required this.onTap,
    this.isMirrored = false,
  }) : super(key: key);

  @override
  State<HoverIconWidget> createState() => _HoverIconWidgetState();
}

class _HoverIconWidgetState extends State<HoverIconWidget> {
  @override
  Widget build(BuildContext context) {
    return HoverBuilder(
      builder: (isHovered) => GestureDetector(
        onTap: () => widget.onTap(),
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
              child: Transform(
                alignment: Alignment.center,
                transform: widget.isMirrored
                    ? Matrix4.rotationY(3.14159)
                    : Matrix4.identity(),
                child: Icon(
                  widget.icon,
                  size: 18,
                  color: isHovered ? Colors.white : const Color(0xFF8A8E94),
                ),
              ),
            ),
          ),
        ),
      ).discordTooltip(widget.tooltip),
    );
  }
}
