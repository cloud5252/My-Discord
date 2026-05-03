import 'package:flutter/material.dart';
import 'package:my_discord/ui/views/home/center%20panels/chat/chat_view_model.dart';
import 'package:stacked/stacked.dart';

class ChatView extends StackedView<ChatViewModel> {
  final String chatWithId;
  final String chatWithName;

  const ChatView({
    Key? key,
    required this.chatWithId,
    required this.chatWithName,
  }) : super(key: key);

  @override
  Widget builder(BuildContext context, ChatViewModel viewModel, Widget? child) {
    return Container(
      color: const Color(0xFF313338),
      child: Column(
        children: [
          _buildTopHeader(),
          const Divider(color: Color(0xFF1E1F22), height: 1),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              reverse: false,
              children: [
                const SizedBox(height: 40),
                _buildUserProfileHeader(),
                const SizedBox(height: 20),
                const Divider(color: Colors.white10),
                const SizedBox(height: 10),
                _buildMessageBubble(
                    "Programer", "hello sir", "4/9/25, 9:52 PM"),
                _buildMessageBubble("Programer",
                    "rooom karo ge 4v4 broly ka dost hon", "4/9/25, 9:53 PM"),
              ],
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildTopHeader() {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          const Text('@',
              style: TextStyle(color: Color(0xFF80848E), fontSize: 20)),
          const SizedBox(width: 8),
          Text(
            chatWithName,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ],
      ),
    );
  }

// Badi Avatar aur Naam (Start of conversation)
  Widget _buildUserProfileHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CircleAvatar(
          radius: 40,
          backgroundColor: Color(0xFF5865F2),
          child: Icon(Icons.person, color: Colors.white, size: 40),
        ),
        const SizedBox(height: 16),
        Text(
          chatWithName,
          style: const TextStyle(
              color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
        ),
        Text(
          chatWithName.toLowerCase(),
          style: const TextStyle(color: Color(0xFFB5BAC1), fontSize: 20),
        ),
        const SizedBox(height: 12),
        Text(
          'This is the beginning of your direct message history with @$chatWithName.',
          style: const TextStyle(color: Color(0xFFB5BAC1), fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildMessageBubble(String user, String message, String time) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(radius: 20, backgroundColor: Colors.grey),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(user,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600)),
                    const SizedBox(width: 8),
                    Text(time,
                        style: const TextStyle(
                            color: Color(0xFF80848E), fontSize: 11)),
                  ],
                ),
                const SizedBox(height: 2),
                Text(message,
                    style: const TextStyle(
                        color: Color(0xFFDBDEE1), fontSize: 15)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF383A40),
          borderRadius: BorderRadius.circular(8),
        ),
        child: TextField(
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Message @$chatWithName',
            hintStyle: const TextStyle(color: Color(0xFF80848E)),
            prefixIcon: const Icon(Icons.add_circle, color: Color(0xFFB5BAC1)),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 12),
            suffixIcon: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.card_giftcard, color: Color(0xFFB5BAC1)),
                SizedBox(width: 10),
                Icon(Icons.gif, color: Color(0xFFB5BAC1)),
                SizedBox(width: 10),
                Icon(Icons.emoji_emotions, color: Color(0xFFB5BAC1)),
                SizedBox(width: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  ChatViewModel viewModelBuilder(BuildContext context) => ChatViewModel();
}

  // Widget _buildMessagesList(ChatViewModel viewModel) {
  //   if (viewModel.isBusy) {
  //     return const Center(child: CircularProgressIndicator());
  //   }

  //   if (viewModel.messages.isEmpty) {
  //     return const Center(
  //       child: Text('No messages yet!', style: TextStyle(color: Colors.white)),
  //     );
  //   }

  //   return ListView.builder(
  //     padding: const EdgeInsets.all(10),
  //     itemCount: viewModel.messages.length,
  //     itemBuilder: (context, index) {
  //       final message = viewModel.messages[index];
  //       // ✅ isMe check karo
  //       final bool isMe = message.senderId == viewModel.currentUserId;
  //       return _buildMessageBubble(message, isMe);
  //     },
  //   );
  // }

  // Widget _buildMessageBubble(ChatMessage message, bool isMe) {
  //   return Align(
  //     alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
  //     child: Container(
  //       margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
  //       padding: const EdgeInsets.all(10),
  //       decoration: BoxDecoration(
  //         color: isMe ? const Color(0xFF005C4B) : const Color(0xFF242C32),
  //         borderRadius: BorderRadius.circular(12),
  //       ),
  //       child: message.isVoiceMessage
  //           ? _buildVoiceMessageWidget(message, isMe)
  //           : Text(
  //               message.messageText ?? '',
  //               style: const TextStyle(color: Colors.white),
  //             ),
  //     ),
  //   );
  // }

  // Widget _buildVoiceMessageWidget(ChatMessage message, bool isMe) {
  //   return Row(
  //     mainAxisSize: MainAxisSize.min,
  //     children: [
  //       IconButton(
  //         icon: const Icon(Icons.play_arrow, color: Colors.white),
  //         onPressed: () {
  //           // Play audio — next step mein add karenge
  //         },
  //       ),
  //       const SizedBox(width: 8),
  //       Container(
  //         width: 150,
  //         height: 30,
  //         decoration: BoxDecoration(
  //           color: Colors.white24,
  //           borderRadius: BorderRadius.circular(10),
  //         ),
  //         child: const Center(
  //           child: Text(
  //             '🎙️ Voice message',
  //             style: TextStyle(color: Colors.white70, fontSize: 12),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // Widget _buildMessageInput(ChatViewModel viewModel) {
  //   return Padding(
  //     padding: const EdgeInsets.all(10.0),
  //     child: Row(
  //       children: [
  //         Expanded(
  //           child: TextField(
  //             controller: viewModel.messageController,
  //             cursorColor: Colors.white,
  //             style: const TextStyle(color: Colors.white),
  //             decoration: InputDecoration(
  //               hintText: viewModel.isRecording
  //                   ? '🎙️ Listening...'
  //                   : 'Write here...',
  //               hintStyle: TextStyle(
  //                 color: viewModel.isRecording ? Colors.red : Colors.white54,
  //               ),
  //               enabledBorder: OutlineInputBorder(
  //                 borderRadius: BorderRadius.circular(25),
  //                 borderSide: BorderSide(
  //                   color: viewModel.isRecording ? Colors.red : Colors.white24,
  //                 ),
  //               ),
  //               focusedBorder: OutlineInputBorder(
  //                 borderRadius: BorderRadius.circular(25),
  //                 borderSide: BorderSide(
  //                   color: viewModel.isRecording ? Colors.red : Colors.white,
  //                 ),
  //               ),
  //               contentPadding: const EdgeInsets.symmetric(
  //                 horizontal: 16,
  //                 vertical: 10,
  //               ),
  //             ),
  //           ),
  //         ),
  //         const SizedBox(width: 8),
  //         GestureDetector(
  //           onTap: () {
  //             viewModel.sendMessage(viewModel.messageController.text);
  //           },
  //           child: Container(
  //               width: 50,
  //               height: 50,
  //               decoration: BoxDecoration(
  //                   color: const Color(0xFF00A884),
  //                   borderRadius: BorderRadius.circular(15)),
  //               child: IconButton(onPressed: () {}, icon: const Icon(Icons.send))),
  //         ),
  //       ],
  //     ),
  //   );
  // }

//   @override
//   ChatViewModel viewModelBuilder(BuildContext context) => ChatViewModel();
// }
