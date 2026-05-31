import 'package:flutter/material.dart';

class LoginDropdown extends StatelessWidget {
  final String hint;
  final List<String> items;
  final String type;
  final String? selected;
  final bool isOpen;
  final LayerLink layerLink;
  final Function(String, BuildContext, LayerLink, List<String>) onToggle;

  const LoginDropdown({
    super.key,
    required this.hint,
    required this.items,
    required this.type,
    required this.selected,
    required this.isOpen,
    required this.layerLink,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: layerLink,
      child: GestureDetector(
        onTap: () => onToggle(type, context, layerLink, items),
        child: Container(
          height: 42,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: const Color(0xFF35353c),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isOpen ? const Color(0xFF5865F2) : Colors.transparent,
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                selected ?? hint,
                style: TextStyle(
                  color:
                      selected != null ? Colors.white : const Color(0xFFB5BAC1),
                ),
              ),
              Icon(
                isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                color: const Color(0xFFB5BAC1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
