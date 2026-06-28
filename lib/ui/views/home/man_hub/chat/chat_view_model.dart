import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_discord/app/app.locator.dart';
import 'package:my_discord/models/messsage_model.dart';
import 'package:my_discord/service/FB_Auth/Authentication.dart';
import 'package:my_discord/service/chat_service/chat_service.dart';
import 'package:my_discord/service/chat_service/viewService.dart';
import 'package:stacked/stacked.dart';

class ChatViewModel extends ReactiveViewModel implements Initialisable {
  final _auth = locator<Authentication>();
  final _chatService = locator<ChatService>();
  final viewService = locator<ViewService>();
  final String receiverId;
  final String receiverName;

  final TextEditingController messageController = TextEditingController();
  final TextEditingController edittextController = TextEditingController();

  ChatViewModel({
    required this.receiverId,
    required this.receiverName,
  });
  @override
  List<ListenableServiceMixin> get listenableServices => [viewService];
  @override
  void dispose() {
    messageController.dispose();
    scrollController.dispose();
    edittextController.dispose();
    super.dispose();
  }

  final ScrollController scrollController = ScrollController();
  String get myUid => _auth.getCurrentuser()?.uid ?? '';
  String get myEmail => _auth.getCurrentuser()?.email ?? '';

  Stream<List<MessageModel>> get messagesStream =>
      _chatService.getMessages(receiverId);
  // Stream<List<MessageModel>>? get messagesStream => null;
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
      replyToMessageId: replyingTo?.firebaseId,
      replyToText: replyingTo?.messageText,
      replyToSender: replyingTo?.senderEmail,
    );

    replyingTo = null; // ← send ke baad clear
    notifyListeners();

    if (scrollController.hasClients) {
      scrollController.animateTo(
        0.0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    }
  }

  bool get isSendButtonActive => messageController.text.trim().isNotEmpty;

  String? _hoveredMessageId;
  String? get hoveredMessageId => _hoveredMessageId;

  void setHoveredMessage(String? id) {
    _hoveredMessageId = id;
    notifyListeners();
  }

  MessageModel? replyingTo;

  void onReplyMessage(MessageModel message) {
    replyingTo = message;
    notifyListeners();
  }

  void cancelReply() {
    replyingTo = null;
    notifyListeners();
  }

  MessageModel? editingMessage;

  void startEditing(MessageModel message) {
    editingMessage = message;
    edittextController.text = message.messageText ?? ''; // ✅
    notifyListeners();
  }

  void cancelEditing() {
    editingMessage = null;
    edittextController.clear();
    notifyListeners();
  }

  Future<void> sendOrEditMessage() async {
    if (editingMessage != null) {
      final newText = edittextController.text.trim();
      if (newText.isEmpty) return;

      // ← PEHLE LOCAL UPDATE — instant UI
      editingMessage!.messageText = newText;
      editingMessage!.isEdited = true;
      await editingMessage!.save(); // Hive update
      _chatService.emitMessages(editingMessage!.chatRoomId!); // UI refresh

      final messageToEdit = editingMessage!;
      editingMessage = null; // ← editing mode band karo
      edittextController.clear();
      notifyListeners(); // ← UI turant update

      // ← BAAD MEIN FIREBASE — background mein
      await _chatService.editMessage(
        message: messageToEdit,
        newText: newText,
      );
    } else {
      await sendMessage();
    }
  }

  void showOptions(MessageModel message) {
    print("Options for message ID: ${message.firebaseId}");
  }

  void deleteMessage(MessageModel message) async {
    await _chatService.deleteMessage(message);
  }

  void copyMessage(MessageModel message) {
    Clipboard.setData(ClipboardData(text: message.messageText ?? ''));
  }
}
