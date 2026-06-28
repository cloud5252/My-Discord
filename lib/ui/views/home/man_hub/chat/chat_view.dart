import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_discord/models/messsage_model.dart';
import 'package:my_discord/ui/views/home/man_hub/chat/chat_view_model.dart';
import 'package:my_discord/ui/views/home/man_hub/chat/widget/chat_top_header.dart';
import 'package:my_discord/ui/views/home/man_hub/chat/widget/message_bubble_widget.dart';
import 'package:my_discord/ui/views/home/man_hub/active_or_profile/profile_panel/profile_panel_view.dart';
import 'package:my_discord/ui/views/home/man_hub/chat/widget/user_type_text_field.dart';
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
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: Colors.grey.shade500, width: 0.2),
          top: BorderSide(color: Colors.grey.shade500, width: 0.2),
        ),
      ),
      child: Column(
        children: [
          ChatTopHeader(
            chatWithName: chatWithName,
            viewService: viewModel.viewService,
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: StreamBuilder<List<MessageModel>>(
                          key: ValueKey(viewModel.receiverId),
                          stream: viewModel.messagesStream,
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const SizedBox.shrink();
                            }
                            final messages =
                                snapshot.data?.reversed.toList() ?? [];
                            return ListView.builder(
                              reverse: true,
                              cacheExtent: 1000,
                              padding: EdgeInsets.zero,
                              controller: viewModel.scrollController,
                              itemCount: messages.length + 1,
                              itemBuilder: (context, index) {
                                if (index == messages.length) {
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
                                        const Text('No messages yet!',
                                            style: TextStyle(
                                                color: Color(0xFF80848E))),
                                    ],
                                  );
                                }
                                final message = messages[index];
                                return MessageBubbleWidget(
                                  chatViewModel: viewModel,
                                  message: message,
                                  key: ValueKey(
                                      message.firebaseId ?? index.toString()),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      _buildMessageInput(viewModel),
                    ],
                  ),
                ),
                ValueListenableBuilder<bool>(
                  valueListenable: viewModel.viewService.showProfileNotifier,
                  builder: (context, showProfile, _) {
                    if (viewModel.viewService.isCompact) {
                      return const SizedBox.shrink();
                    }
                    if (showProfile) {
                      return ProfilePanel(userId: chatWithId);
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ],
            ),
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (viewModel.replyingTo != null)
          Container(
            color: const Color(0xFF2B2D31),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                const Icon(Icons.reply, color: Color(0xFF5865F2), size: 16),
                const SizedBox(width: 8),
                Text(
                  'Replying to ${viewModel.replyingTo!.senderEmail ?? ""}',
                  style: const TextStyle(
                    color: Color(0xFF5865F2),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => viewModel.cancelReply(),
                  child: const Icon(Icons.close,
                      color: Color(0xFF80848E), size: 16),
                ),
              ],
            ),
          ),
        Padding(
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
                  selection:
                      TextSelection.collapsed(offset: selection.start + 1),
                );
              },
            },
            child: ChatInputField(
              controller: viewModel.messageController,
              chatWithName: chatWithName,
              onSend: viewModel.sendMessage,
            ),
          ),
        ),
      ],
    );
  }

  @override
  ChatViewModel viewModelBuilder(BuildContext context) => ChatViewModel(
        receiverId: chatWithId,
        receiverName: chatWithName,
      );
}
