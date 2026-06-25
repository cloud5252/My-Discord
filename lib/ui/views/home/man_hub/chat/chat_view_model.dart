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
    );

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

  void onReplyMessage(MessageModel message) {
    print("Replying to: ${message.messageText}");
  }

  void showOptions(MessageModel message) {
    print("Options for message ID: ${message.firebaseId}");
  }

  void deleteMessage(MessageModel message) {
    print("Deleting message: ${message.firebaseId}");
  }

  void copyMessage(MessageModel message) {
    Clipboard.setData(ClipboardData(text: message.messageText ?? ''));
  }
}
