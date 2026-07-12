import 'package:flutter/material.dart';
import 'package:my_discord/ui/views/home/man_hub/chat/chat_view_model.dart';
import 'package:my_discord/ui/views/home/man_hub/chat/popup_menu/pinned_message_popup.dart';

class PinnedMessagesController {
  static OverlayEntry? _entry;

  static bool get isOpen => _entry != null;

  static void show(
    BuildContext context,
    Offset position,
    ChatViewModel chatViewModel,
  ) {
    if (_entry != null) {
      hide();
      return;
    }

    _entry = OverlayEntry(
      builder: (ctx) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: hide,
            ),
          ),
          PinnedMessagesPopup(
            position: position,
            chatViewModel: chatViewModel,
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
}
