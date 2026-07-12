import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_discord/app/app.dialogs.dart';
import 'package:my_discord/app/app.locator.dart';
import 'package:my_discord/models/messsage_model.dart';
import 'package:my_discord/service/FB_Auth/Authentication.dart';
import 'package:my_discord/service/chat_service/chat_service.dart';
import 'package:my_discord/service/chat_service/viewService.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ChatViewModel extends ReactiveViewModel implements Initialisable {
  final _dialogService = locator<DialogService>();

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

    replyingTo = null;
    notifyListeners();

    if (scrollController.hasClients) {
      scrollController.animateTo(
        0.0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    }
  }

  void copyMessage(MessageModel message) {
    final text = message.messageText ?? '';
    if (text.isEmpty) return;

    Clipboard.setData(ClipboardData(text: text));
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
    edittextController.text = message.messageText ?? '';
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

      editingMessage!.messageText = newText;
      editingMessage!.isEdited = true;
      await editingMessage!.save();
      _chatService.emitMessages(editingMessage!.chatRoomId!);

      final messageToEdit = editingMessage!;
      editingMessage = null;
      edittextController.clear();
      notifyListeners();

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

  String? highlightMessageId;

  final Map<String, GlobalKey> messageKeys = {};

  GlobalKey keyFor(String messageId) {
    return messageKeys.putIfAbsent(messageId, () => GlobalKey());
  }

  List<String> _currentMessageIds = [];
  void updateMessageOrder(List<String> ids) {
    _currentMessageIds = ids;
  }

  void scrollToMessage(String messageId, {int attempts = 0}) {
    final key = messageKeys[messageId];

    if (key?.currentContext != null) {
      Scrollable.ensureVisible(
        key!.currentContext!,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        alignment: 0.5,
      );
      _flashHighlight(messageId);
      return;
    }

    if (attempts > 15) {
      debugPrint('Target message not found after retries: $messageId');
      return;
    }

    final index = _currentMessageIds.indexOf(messageId);
    if (index == -1) return;

    if (scrollController.hasClients) {
      scrollController
          .animateTo(
        scrollController.offset + 300,
        duration: const Duration(milliseconds: 100),
        curve: Curves.linear,
      )
          .then((_) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          scrollToMessage(messageId, attempts: attempts + 1);
        });
      });
    }
  }

  void _flashHighlight(String messageId) {
    highlightMessageId = messageId;
    notifyListeners();
    Future.delayed(const Duration(milliseconds: 1200), () {
      highlightMessageId = null;
      notifyListeners();
    });
  }

  Future<void> toggleReaction(MessageModel message, String emoji) async {
    final currentUserId = myUid;

    final reactions = Map<String, List<String>>.from(message.reactions);
    final usersForEmoji = List<String>.from(reactions[emoji] ?? []);

    if (usersForEmoji.contains(currentUserId)) {
      usersForEmoji.remove(currentUserId);
    } else {
      usersForEmoji.add(currentUserId);
    }

    if (usersForEmoji.isEmpty) {
      reactions.remove(emoji);
    } else {
      reactions[emoji] = usersForEmoji;
    }

    message.reactions = reactions;

    notifyListeners();

    await message.save();

    _chatService.syncReactionToFirestore(
        message: message, reactions: reactions);
  }

  void insertEmojiIntoInput(String emoji) {
    final text = messageController.text;
    final selection = messageController.selection;

    final start = selection.start >= 0 ? selection.start : text.length;
    final end = selection.end >= 0 ? selection.end : text.length;

    final newText = text.replaceRange(start, end, emoji);

    messageController.value = TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: start + emoji.length),
    );

    notifyListeners();
  }

  Future<void> showPinMessageDialog(MessageModel message) async {
    final response = await _dialogService.showCustomDialog(
      variant: DialogType.pinMessage,
      title: 'Pin It. Pin It Good.',
      description:
          'Hey, just double checking that you want to pin this message to the current channel for posterity and greatness?',
      data: message,
    );

    if (response?.confirmed == true) {
      await pinMessage(message);
    }
  }

  Future<void> pinMessage(MessageModel message) async {
    message.isPinned = true;
    await message.save();
    notifyListeners();

    _chatService.syncPinToFirestore(message: message, isPinned: true);
  }

  Future<void> unpinMessage(MessageModel message) async {
    message.isPinned = false;
    await message.save();
    notifyListeners();

    _chatService.syncPinToFirestore(message: message, isPinned: false);
  }

  Stream<List<MessageModel>> get pinnedMessagesStream => messagesStream.map(
        (messages) => messages.where((m) => m.isPinned == true).toList(),
      );
}
