import 'package:flutter/material.dart';

class PressBuilder extends StatefulWidget {
  final Widget Function(bool isPressed) builder;
  final VoidCallback onTap;

  const PressBuilder({
    Key? key,
    required this.builder,
    required this.onTap,
  }) : super(key: key);

  @override
  State<PressBuilder> createState() => _PressBuilderState();
}

class _PressBuilderState extends State<PressBuilder> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      child: widget.builder(_isPressed),
    );
  }
}