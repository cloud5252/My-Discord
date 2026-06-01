// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:my_discord/ui/common/hover_builder.dart';
import 'package:my_discord/ui/common/press_builder.dart';

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const CustomCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return HoverBuilder(
      key: ValueKey(value),
      builder: (isHovered) => PressBuilder(
        onTap: () => onChanged(!value),
        builder: (isPressed) => AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: value
                ? const Color(0xFF5865F2)
                : isPressed
                    ? const Color(0xFF5865F2).withOpacity(0.2)
                    : Colors.transparent,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: value
                  ? const Color(0xFF5865F2)
                  : isHovered
                      ? const Color(0xFF80848E)
                      : const Color(0xFF80848E),
              width: 1.5,
            ),
          ),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 100),
            child: value
                ? const Icon(
                    key: ValueKey('checked'),
                    Icons.check,
                    color: Colors.white,
                    size: 14,
                  )
                : const SizedBox.shrink(
                    key: ValueKey('unchecked'),
                  ),
          ),
        ),
      ),
    );
  }
}
