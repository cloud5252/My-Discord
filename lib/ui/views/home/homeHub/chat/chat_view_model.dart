import 'package:stacked/stacked.dart';

class ChatViewModel extends BaseViewModel {
  // final TextEditingController messageController = TextEditingController();
  // // final _chatService = locator<ChatService>();
  // final _navigationService = locator<NavigationService>();
  // final _auth = locator<Authentication>();

  // final String receiverId;
  // final String receiverName;
  // // List<ChatMessage> get messages => data ?? [];

  // ChatViewModel({
  //   required this.receiverId,
  //   required this.receiverName,
  // }) {
  //   messageController.addListener(() {
  //     rebuildUi();
  //   });
  // }

  // String get currentUserId => _auth.getCurrentuser()?.uid ?? '';
  // String get currentUserEmail => _auth.getCurrentuser()?.email ?? '';
  // String get currentUserName => _auth.getCurrentuser()?.displayName ?? '';

  // @override
  // Stream<List<ChatRoom>> get stream => _chatService.getChatRooms(currentUserId);

  // Future<void> sendMessage([String? text]) async {
  //   final messageText = text ?? messageController.text.trim();
  //   if (messageText.isEmpty) return;
  //   messageController.clear();

  //   await _chatService.sendMessage(
  //     receiverId: receiverId,
  //     messageText: messageText,
  //   );
  // }

  // void navigatorPop() {
  //   _navigationService.back();
  // }

  // @override
  // void dispose() {
  //   messageController.dispose();
  //   super.dispose();
  // }

  // bool isRecording = false;
}
