// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:my_discord/ui/views/home/man_hub/chat/context_manu/sub_manu/emoji_submanu_controller.dart';
import 'package:my_discord/ui/views/home/man_hub/chat/context_manu/widget/hover_emoji_widget.dart';

class ContextMenuItem {
  final String label;
  final IconData icon;
  final Color? color;
  final VoidCallback onTap;
  final bool isDivider;
  final double iconRotation;
  final bool iconMirror;
  final bool hasSubmenu;

  ContextMenuItem({
    this.label = '',
    this.icon = Icons.circle,
    this.hasSubmenu = false,
    this.color,
    VoidCallback? onTap,
    this.iconRotation = 0.0,
    this.isDivider = false,
    this.iconMirror = false,
  }) : onTap = onTap ?? (() {});

  ContextMenuItem.divider()
      : label = '',
        icon = Icons.circle,
        hasSubmenu = false,
        color = null,
        onTap = (() {}),
        isDivider = true,
        iconRotation = 0.0,
        iconMirror = false;
}

class ContextMenuOverlay extends StatefulWidget {
  final Offset position;
  final List<ContextMenuItem> items;
  final VoidCallback onDismiss;

  const ContextMenuOverlay({
    super.key,
    required this.position,
    required this.items,
    required this.onDismiss,
  });

  @override
  State<ContextMenuOverlay> createState() => _ContextMenuOverlayState();
}

class _ContextMenuOverlayState extends State<ContextMenuOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;
  late Animation<double> _opacity;

  static const double _verticalOffset = 4.0;
  static const double _horizontalOffset = 0.0;

  double left = 0;
  double top = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scale = CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic);
    _opacity = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _controller.forward();
    _calculatePosition();
  }

  @override
  void didUpdateWidget(covariant ContextMenuOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    _calculatePosition();
  }

  void _calculatePosition() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      final screenSize = MediaQuery.of(context).size;
      const menuWidth = 220.0;

      double menuHeight = 12.0;
      for (var item in widget.items) {
        menuHeight += item.isDivider ? 9.0 : 36.0;
      }

      double localLeft = widget.position.dx - menuWidth + _horizontalOffset;
      double localTop = widget.position.dy + _verticalOffset;

      if (localLeft + menuWidth > screenSize.width) {
        localLeft = screenSize.width - menuWidth - 8;
      }
      if (localLeft < 8) localLeft = 8;

      const double bottomSafeArea = 70.0;
      if (localTop + menuHeight > screenSize.height - bottomSafeArea) {
        localTop = (screenSize.height - bottomSafeArea) - menuHeight;
      }

      const double topSafeArea = 10.0;
      if (localTop < topSafeArea) localTop = topSafeArea;

      setState(() {
        left = localLeft;
        top = localTop;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (left == 0 && top == 0) return const SizedBox.shrink();

    return Stack(
      children: [
        Positioned(
          left: left,
          top: top,
          child: ScaleTransition(
            scale: _scale,
            alignment: top < widget.position.dy
                ? Alignment.bottomRight
                : Alignment.topRight,
            child: FadeTransition(
              opacity: _opacity,
              child: Material(
                color: Colors.transparent,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {},
                  child: Container(
                    width: 220.0,
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1B1E3F),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: const Color(0xFF2B305B),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          blurRadius: 16,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              HoverEmojiWidget(emoji: '❤️', tooltip: 'Heart'),
                              HoverEmojiWidget(
                                  emoji: '🔖', tooltip: 'Bookmark'),
                              HoverEmojiWidget(
                                  emoji: '👍', tooltip: 'Thumbs Up'),
                              HoverEmojiWidget(emoji: '😊', tooltip: 'Smile'),
                            ],
                          ),
                        ),
                        ...widget.items.map((item) {
                          if (item.isDivider) {
                            return const Padding(
                              padding: EdgeInsets.symmetric(vertical: 4),
                              child:
                                  Divider(height: 1, color: Color(0xFF2B305B)),
                            );
                          }
                          return _MenuTile(
                            item: item,
                            onTap: () {
                              widget.onDismiss();
                              item.onTap();
                            },
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _MenuTile extends StatefulWidget {
  final ContextMenuItem item;
  final VoidCallback onTap;

  const _MenuTile({required this.item, required this.onTap});

  @override
  State<_MenuTile> createState() => _MenuTileState();
}

class _MenuTileState extends State<_MenuTile> {
  bool _hovered = false;

  // Key Container pe hai — renderBox sahi milega
  final GlobalKey _containerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final color = widget.item.color ?? const Color(0xFFDCDDDE);

    return MouseRegion(
      onEnter: (_) {
        setState(() => _hovered = true);
        if (widget.item.hasSubmenu) {
          final renderBox =
              _containerKey.currentContext!.findRenderObject() as RenderBox;
          final position = renderBox.localToGlobal(Offset.zero);
          EmojiSubmenuController.show(context, position);
        } else {
          EmojiSubmenuController.hide();
        }
      },
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          key: _containerKey,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          decoration: BoxDecoration(
            color: _hovered
                ? const Color(0xFFc6c5c1).withOpacity(0.05)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            children: [
              Text(
                widget.item.label,
                style: TextStyle(
                  color: color,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              if (widget.item.hasSubmenu)
                const Icon(
                  Icons.chevron_right,
                  size: 20,
                  color: Color(0xFFDCDDDE),
                )
              else
                Transform(
                  alignment: Alignment.center,
                  transform: widget.item.iconMirror
                      ? Matrix4.rotationY(3.14159)
                      : Matrix4.rotationZ(widget.item.iconRotation),
                  child: Icon(
                    widget.item.icon,
                    size: 20,
                    color: color,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
