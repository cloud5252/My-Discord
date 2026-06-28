import 'package:flutter/material.dart';
import 'package:my_discord/ui/views/home/man_hub/chat/context_manu/sub_manu/emoji_submanu_widget.dart';

class EmojiSubmenuController {
  static OverlayEntry? _entry;

  static void show(BuildContext context, Offset position) {
    if (_entry != null) return;

    _entry = OverlayEntry(
      builder: (ctx) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: hide,
            ),
          ),
          EmojiSubmenuWidget(
            position: position,
            onDismiss: hide,
          ),
        ],
      ),
    );

    Overlay.of(context).insert(_entry!);
  }

  static void hide() {
    _entry?.remove();
    _entry = null;
  }

  static bool get isOpen => _entry != null;
}
