import 'package:flutter/material.dart';

extension DiscordTooltipExtension on Widget {
  Widget withDiscordTooltip(
    String message, {
    bool preferBelow = false,
  }) {
    return Tooltip(
      message: message,
      preferBelow: preferBelow,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      waitDuration: Duration.zero,
      showDuration: Duration.zero,
      decoration: BoxDecoration(
        color: const Color(0xFF242429),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF323237), width: 0.9),
        boxShadow: const [
          BoxShadow(
            color: Color(0x66000000),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      textStyle: const TextStyle(
        color: Colors.white,
        fontSize: 11,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.2,
      ),
      child: this,
    );
  }
}
