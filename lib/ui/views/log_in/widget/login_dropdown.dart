import 'package:flutter/material.dart';

class LoginDropdown extends StatelessWidget {
  final String hint;
  final List<String> items;

  const LoginDropdown({
    super.key,
    required this.hint,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      hint: Text(hint, style: const TextStyle(color: Color(0xFFB5BAC1))),
      dropdownColor: const Color(0xFF2B2D31),
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFF1E1F22),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide.none,
        ),
      ),
      items: items
          .map((item) => DropdownMenuItem(value: item, child: Text(item)))
          .toList(),
      onChanged: (_) {},
    );
  }
}