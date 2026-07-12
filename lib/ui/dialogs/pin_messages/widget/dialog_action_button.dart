// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:my_discord/ui/common/hover_builder.dart';
import 'package:my_discord/ui/common/press_builder.dart';

class DialogActionButton extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback onTap;
  final FontWeight fontWeight;

  const DialogActionButton({
    Key? key,
    required this.label,
    required this.backgroundColor,
    required this.onTap,
    this.textColor = Colors.white,
    this.fontWeight = FontWeight.normal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HoverBuilder(
      builder: (isHovered) => PressBuilder(
        onTap: onTap,
        builder: (isPressed) {
          final color = isPressed
              ? backgroundColor.withOpacity(0.7)
              : isHovered
                  ? backgroundColor.withOpacity(0.85)
                  : backgroundColor;

          return MouseRegion(
            cursor: SystemMouseCursors.click,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(6),
              ),
              alignment: Alignment.center,
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 15,
                  color: textColor,
                  fontWeight: fontWeight,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
