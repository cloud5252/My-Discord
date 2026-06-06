import 'package:flutter/material.dart';

extension DiscordTooltipExtension on Widget {
  Widget signUptooltip(String message, {bool preferBelow = true}) {
    return DiscordTooltipPortal(
      message: message,
      preferBelow: preferBelow,
      child: this,
    );
  }
}

class DiscordTooltipPortal extends StatefulWidget {
  final Widget child;
  final String message;
  final bool preferBelow;

  const DiscordTooltipPortal({
    Key? key,
    required this.child,
    required this.message,
    this.preferBelow = true,
  }) : super(key: key);

  @override
  State<DiscordTooltipPortal> createState() => _DiscordTooltipPortalState();
}

class _DiscordTooltipPortalState extends State<DiscordTooltipPortal> {
  OverlayEntry? _entry;
  final LayerLink _link = LayerLink();

  void _show() {
    if (_entry != null) return;
    if (widget.message.isEmpty) return;
    _entry = OverlayEntry(
      builder: (_) => IgnorePointer(
        child: CompositedTransformFollower(
          link: _link,
          showWhenUnlinked: false,
          targetAnchor:
              widget.preferBelow ? Alignment.bottomCenter : Alignment.topCenter,
          followerAnchor:
              widget.preferBelow ? Alignment.topCenter : Alignment.topCenter,
          offset: Offset(0, widget.preferBelow ? 5 : -55),
          child: RepaintBoundary(
            child: Align(
              alignment: Alignment.topCenter,
              child: _TooltipBox(message: widget.message),
            ),
          ),
        ),
      ),
    );
    Overlay.of(context, rootOverlay: true).insert(_entry!);
  }

  void _hide() {
    _entry?.remove();
    _entry = null;
  }

  @override
  void dispose() {
    _hide();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _link,
      child: MouseRegion(
        onEnter: (_) => _show(),
        onExit: (_) => _hide(),
        child: widget.child,
      ),
    );
  }
}

class _TooltipBox extends StatelessWidget {
  final String message;
  const _TooltipBox({required this.message});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFF242429),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFF5e5d5e), width: 0.8),
          boxShadow: const [
            BoxShadow(
              color: Color(0x88000000),
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          message,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
          softWrap: false,
        ),
      ),
    );
  }
}
