import 'dart:async';
import 'package:flutter/material.dart';
import 'package:my_discord/ui/views/home/man_hub/chat/context_manu/sub_manu/emoji_submanu_widget.dart';

class EmojiSubmenuController {
  static OverlayEntry? _entry;
  static Timer? _hideTimer;

  static void show(
    BuildContext context,
    Offset position,
    ValueChanged<String> onEmojiSelected,
  ) {
    _hideTimer?.cancel();
    _hideTimer = null;

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
            onEmojiSelected: onEmojiSelected,
          ),
        ],
      ),
    );

    Overlay.of(context).insert(_entry!);
  }

  static void cancelHide() {
    _hideTimer?.cancel();
    _hideTimer = null;
  }

  static void scheduleHide() {
    _hideTimer?.cancel();
    _hideTimer = Timer(const Duration(milliseconds: 60), () {
      hide();
    });
  }

  static void hide() {
    _hideTimer?.cancel();
    _hideTimer = null;
    _entry?.remove();
    _entry = null;
  }

  static bool get isOpen => _entry != null;
}
