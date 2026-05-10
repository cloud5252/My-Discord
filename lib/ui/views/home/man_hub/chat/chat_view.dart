import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_discord/models/messsage_model.dart';
import 'package:my_discord/ui/views/home/man_hub/chat/chat_view_model.dart';
import 'package:my_discord/ui/views/home/man_hub/chat/widget/message_bubble_widget.dart';
import 'package:my_discord/ui/views/home/man_hub/dmSide/active_panel/profile_panel.dart';
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
      color: const Color(0xFF1a1a1e),
      child: Column(
        children: [
          _buildTopHeader(),
          const Divider(color: Color(0xFF1E1F22), height: 1),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: StreamBuilder<List<MessageModel>>(
                          key: ValueKey(viewModel.receiverId),
                          stream: viewModel.messagesStream,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(
                                    color: Color(0xFF5865F2)),
                              );
                            }
                            final messages = snapshot.data ?? [];
                            return ListView.builder(
                              itemCount: messages.length + 1,
                              itemBuilder: (context, index) {
                                if (index == 0) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 40),
                                      _buildUserProfileHeader(),
                                      const SizedBox(height: 20),
                                      const Divider(color: Colors.white10),
                                      const SizedBox(height: 10),
                                      if (messages.isEmpty)
                                        const Padding(
                                          padding: EdgeInsets.all(20),
                                          child: Text('No messages yet!',
                                              style: TextStyle(
                                                  color: Color(0xFF80848E))),
                                        ),
                                    ],
                                  );
                                }
                                final message = messages[index - 1];
                                return MessageBubbleWidget(message: message);
                              },
                            );
                          },
                        ),
                      ),
                      _buildMessageInput(viewModel),
                    ],
                  ),
                ),
                const ProfilePanel(),
              ],
            ),
          ),
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

  Widget _buildUserProfileHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
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
      ),
    );
  }

  Widget _buildMessageInput(ChatViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: CallbackShortcuts(
        bindings: {
          const SingleActivator(LogicalKeyboardKey.enter): () {
            if (viewModel.messageController.text.trim().isNotEmpty) {
              viewModel.sendMessage();
            }
          },
          const SingleActivator(LogicalKeyboardKey.enter, shift: true): () {
            final controller = viewModel.messageController;
            final selection = controller.selection;
            final newText = controller.text
                .replaceRange(selection.start, selection.end, '\n');
            controller.value = TextEditingValue(
              text: newText,
              selection: TextSelection.collapsed(offset: selection.start + 1),
            );
          },
        },
        child: TextField(
          controller: viewModel.messageController,
          style: const TextStyle(color: Colors.white),
          cursorColor: Colors.white,
          autofocus: false,
          textAlignVertical: TextAlignVertical.center,
          maxLines: null,
          decoration: InputDecoration(
            hintText: 'Message @$chatWithName',
            hoverColor: Colors.transparent,
            hintStyle: const TextStyle(color: Color(0xFF80848E)),
            fillColor: const Color(0xFF222327),
            filled: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            prefixIcon: const Icon(Icons.add_circle, color: Color(0xFFB5BAC1)),
            suffixIcon: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.card_giftcard, color: Color(0xFFB5BAC1), size: 20),
                SizedBox(width: 8),
                Icon(Icons.gif_box_outlined,
                    color: Color(0xFFB5BAC1), size: 20),
                SizedBox(width: 8),
                Icon(Icons.emoji_emotions_outlined,
                    color: Color(0xFFB5BAC1), size: 20),
                SizedBox(width: 12),
              ],
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide:
                  const BorderSide(color: Color(0xFF48484b), width: 1.0),
            ),
          ),
        ),
      ),
    );
  }

  @override
  ChatViewModel viewModelBuilder(BuildContext context) => ChatViewModel(
        receiverId: chatWithId,
        receiverName: chatWithName,
      );
}
