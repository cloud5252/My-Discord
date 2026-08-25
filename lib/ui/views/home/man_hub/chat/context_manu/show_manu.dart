import 'package:flutter/material.dart';
import 'package:my_discord/ui/views/home/man_hub/chat/context_manu/ui_manu_item.dart';

class DiscordContextMenu {
  static OverlayEntry? _overlayEntry;
  static String? _currentMessageId;

  static bool get isOpen => _overlayEntry != null;

  static void hide() {
    _remove();
  }

  static void show({
    required BuildContext context,
    required Offset position,
    required List<ContextMenuItem> items,
    VoidCallback? onDismiss,
    ValueChanged<String>? onEmojiSelected,
    required String messageId,
  }) {
    if (_overlayEntry != null) {
      if (_currentMessageId == messageId) {
        _remove(onDismiss: onDismiss);
        return;
      }
      _remove();
    }

    _currentMessageId = messageId;
    final overlay = Overlay.of(context);

    _overlayEntry = OverlayEntry(
      builder: (ctx) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => _remove(onDismiss: onDismiss),
            ),
          ),
          ContextMenuOverlay(
            position: position,
            items: items,
            onDismiss: () => _remove(onDismiss: onDismiss),
            onEmojiSelected: onEmojiSelected,
          ),
        ],
      ),
    );

    overlay.insert(_overlayEntry!);
  }

  static void _remove({VoidCallback? onDismiss}) {
    if (_overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
    _currentMessageId = null;
    onDismiss?.call();
  }
}
