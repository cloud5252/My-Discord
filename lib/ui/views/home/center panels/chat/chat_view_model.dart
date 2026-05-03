import 'package:flutter/material.dart';
import 'package:my_discord/app/app.locator.dart';
import 'package:my_discord/models/messsage_model.dart';
import 'package:my_discord/service/FB_Auth/Authentication.dart';
import 'package:my_discord/service/chat_service/chat_service.dart';
import 'package:stacked/stacked.dart';

class ChatViewModel extends BaseViewModel {
  final _auth = locator<Authentication>();
  final _chatService = locator<ChatService>();

  final String receiverId;
  final String receiverName;

  final TextEditingController messageController = TextEditingController();

  ChatViewModel({
    required this.receiverId,
    required this.receiverName,
  });

  String get myUid => _auth.getCurrentuser()?.uid ?? '';
  String get myEmail => _auth.getCurrentuser()?.email ?? '';

  Stream<List<MessageModel>> get messagesStream =>
      _chatService.getMessages(receiverId);

  @override
  void initialise() {
    messageController.addListener(notifyListeners);
  }

  Future<void> sendMessage() async {
    final text = messageController.text.trim();
    if (text.isEmpty) return;
    messageController.clear();

    await _chatService.sendMessage(
      receiverId: receiverId,
      messageText: text,
    );
  }

  // ─── Helpers ───────────────────────────────────────────
  bool get isSendButtonActive => messageController.text.trim().isNotEmpty;

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }
}
