// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';

class EmojiSubmenuWidget extends StatefulWidget {
  final Offset position;
  final VoidCallback onDismiss;

  const EmojiSubmenuWidget({
    Key? key,
    required this.position,
    required this.onDismiss,
  }) : super(key: key);

  @override
  State<EmojiSubmenuWidget> createState() => _EmojiSubmenuWidgetState();
}

class _EmojiSubmenuWidgetState extends State<EmojiSubmenuWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;

  static const List<Map<String, String>> _emojis = [
    {'emoji': '🎁', 'label': 'Gift Heart'},
    {'emoji': '👍', 'label': 'Thumbs Up'},
    {'emoji': '❤️', 'label': 'Heart'},
    {'emoji': '✅', 'label': 'Check Mark'},
    {'emoji': '🌕', 'label': 'Full Moon'},
    {'emoji': '😪', 'label': 'Sleepy'},
    {'emoji': '😕', 'label': 'Confused'},
    {'emoji': '🖤', 'label': 'Black Heart'},
    {'emoji': '👀', 'label': 'Eyes'},
    {'emoji': '😨', 'label': 'Fearful'},
    {'emoji': '🇵🇭', 'label': 'Flag'},
    {'emoji': '😂', 'label': 'Joy'},
  ];

  double left = 0;
  double top = 0;
  bool _positioned = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 80),
    );
    _opacity = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _controller.forward();
    WidgetsBinding.instance.addPostFrameCallback((_) => _calculatePosition());
  }

  void _calculatePosition() {
    if (!mounted) return;
    final screen = MediaQuery.of(context).size;
    const submenuWidth = 200.0;
    const submenuHeight = 280.0;

    double localLeft = widget.position.dx + 225;
    double localTop = widget.position.dy;

    if (localLeft + submenuWidth > screen.width) {
      localLeft = widget.position.dx - submenuWidth;
    }
    if (localTop + submenuHeight > screen.height - 8) {
      localTop = screen.height - submenuHeight - 8;
    }
    if (localTop < 40) localTop = 40;

    setState(() {
      left = localLeft;
      top = localTop;
      _positioned = true;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_positioned) return const SizedBox.shrink();

    return Positioned(
      left: left,
      top: top,
      child: FadeTransition(
        opacity: _opacity,
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: 200,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF1B1E3F),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFF2B305B)),
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
                GridView.count(
                  crossAxisCount: 6,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  children: _emojis.map((e) {
                    return _EmojiCell(
                      emoji: e['emoji']!,
                      label: e['label']!,
                      onTap: widget.onDismiss,
                    );
                  }).toList(),
                ),
                const Divider(height: 8, color: Color(0xFF2B305B)),
                const MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    child: Row(
                      children: [
                        Text(
                          'View More',
                          style: TextStyle(
                            color: Color(0xFFDCDDDE),
                            fontSize: 13,
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.sentiment_satisfied_alt,
                          size: 16,
                          color: Color(0xFFDCDDDE),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EmojiCell extends StatefulWidget {
  final String emoji;
  final String label;
  final VoidCallback onTap;

  const _EmojiCell({
    required this.emoji,
    required this.label,
    required this.onTap,
  });

  @override
  State<_EmojiCell> createState() => _EmojiCellState();
}

class _EmojiCellState extends State<_EmojiCell> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          decoration: BoxDecoration(
            color: _hovered
                ? const Color(0xFF5865F2).withOpacity(0.2)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Text(
              widget.emoji,
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
