import 'package:flutter/material.dart';
import 'package:my_discord/ui/views/home/homeHub/chat/chat_view_model.dart';
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
    // ← Scaffold nahi — sirf Container
    return Container(
      color: const Color(0xFF313338),
      child: Column(
        children: [
          // Header
          Container(
            color: const Color(0xFF313338),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 16,
                  backgroundColor: Color(0xFF5865F2),
                  child: Icon(Icons.person, color: Colors.white, size: 16),
                ),
                const SizedBox(width: 10),
                Text(
                  chatWithName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const Divider(color: Color(0xFF1E1F22), height: 1),

          // Chat area
          const Expanded(
            child: Center(
              child: Text(
                'Start a conversation!',
                style: TextStyle(color: Color(0xFF80848E)),
              ),
            ),
          ),
        ],
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
