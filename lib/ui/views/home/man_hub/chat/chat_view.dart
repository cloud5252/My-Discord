import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_discord/ui/views/home/man_hub/chat/chat_view_model.dart';
import 'package:my_discord/ui/views/home/man_hub/chat/widget/chat_message_list.dart';
import 'package:my_discord/ui/views/home/man_hub/chat/widget/chat_top_header.dart';
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
        color: const Color(0xFF1a1a1e),
        border: Border(
          top: BorderSide(color: Colors.grey.shade700, width: 0.2),
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
                        child: ChatMessageList(
                          viewModel: viewModel,
                          chatWithName: chatWithName,
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
                      return Padding(
                        padding:
                            const EdgeInsets.only(right: 5, top: 5, bottom: 5),
                        child: ProfilePanel(userId: chatWithId),
                      );
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

  Widget _buildMessageInput(ChatViewModel viewModel) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
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
              replyingTo: viewModel.replyingTo,
              onCancelReply: viewModel.cancelReply,
              onTapReplyPreview: () {
                if (viewModel.replyingTo?.firebaseId != null) {
                  viewModel.scrollToMessage(viewModel.replyingTo!.firebaseId!);
                }
              },
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
