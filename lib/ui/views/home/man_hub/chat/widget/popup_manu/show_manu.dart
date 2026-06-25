import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_discord/ui/views/home/man_hub/chat/widget/popup_manu/ui_manu_item.dart';

class DiscordContextMenu {
  static OverlayEntry? _overlayEntry;
  static PointerRoute? _globalClickListener;

  static bool get isOpen => _overlayEntry != null;

  static void show({
    required BuildContext context,
    required Offset position,
    required List<ContextMenuItem> items,
    VoidCallback? onDismiss,
  }) {
    if (_overlayEntry != null) {
      _remove(onDismiss: onDismiss);
      return;
    }

    final overlay = Overlay.of(context);

    _overlayEntry = OverlayEntry(
      builder: (ctx) => ContextMenuOverlay(
        position: position,
        items: items,
        onDismiss: () => _remove(onDismiss: onDismiss),
      ),
    );

    overlay.insert(_overlayEntry!);

    _globalClickListener = (PointerEvent event) {
      if (event is PointerUpEvent && _overlayEntry != null) {
        _remove(onDismiss: onDismiss);
      }
    };

    GestureBinding.instance.pointerRouter.addGlobalRoute(_globalClickListener!);
  }

  static void _remove({VoidCallback? onDismiss}) {
    if (_globalClickListener != null) {
      GestureBinding.instance.pointerRouter
          .removeGlobalRoute(_globalClickListener!);
      _globalClickListener = null;
    }
    if (_overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry = null;
      onDismiss?.call();
    }
  }
}
