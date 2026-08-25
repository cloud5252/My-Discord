import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:my_discord/models/messsage_model.dart';
import 'package:my_discord/ui/views/home/man_hub/chat/chat_view_model.dart';
import 'package:my_discord/ui/views/home/man_hub/chat/widget/message_bubble_widget.dart';

class ChatMessageList extends StatelessWidget {
  final ChatViewModel viewModel;
  final String chatWithName;

  const ChatMessageList({
    Key? key,
    required this.viewModel,
    required this.chatWithName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<MessageModel>>(
      key: ValueKey(viewModel.receiverId),
      stream: viewModel.messagesStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox.shrink();
        }

        final messages = snapshot.data?.reversed.toList() ?? [];
        viewModel.updateMessageOrder(
          messages.map((m) => m.firebaseId ?? '').toList(),
        );

        return ListView.builder(
          scrollCacheExtent: const ScrollCacheExtent.pixels(1000),
          reverse: true,
          padding: EdgeInsets.zero,
          controller: viewModel.scrollController,
          itemCount: messages.length + 1,
          itemBuilder: (context, index) {
            if (index == messages.length) {
              return _buildProfileHeader(messages.isEmpty);
            }

            final message = messages[index];
            final previousMessage =
                (index + 1 < messages.length) ? messages[index + 1] : null;

            final showAvatarAndHeader =
                _shouldShowHeader(message, previousMessage);

            return MessageBubbleWidget(
              chatViewModel: viewModel,
              message: message,
              showHeader: showAvatarAndHeader,
              key: viewModel.keyFor(message.firebaseId ?? index.toString()),
            );
          },
        );
      },
    );
  }

  bool _shouldShowHeader(MessageModel current, MessageModel? previous) {
    if (previous == null) return true;

    if (current.senderEmail != previous.senderEmail) return true;

    final currentTime = current.timestamp is DateTime
        ? current.timestamp as DateTime
        : (current.timestamp as dynamic).toDate();
    final previousTime = previous.timestamp is DateTime
        ? previous.timestamp as DateTime
        : (previous.timestamp as dynamic).toDate();

    final gap = currentTime.difference(previousTime);

    if (gap.inMinutes.abs() > 5) return true;

    if (current.replyToMessageId != null) return true;

    return false;
  }

  Widget _buildProfileHeader(bool isEmpty) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
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
          const SizedBox(height: 20),
          const Divider(color: Colors.white10),
          const SizedBox(height: 10),
          if (isEmpty)
            const Text('No messages yet!',
                style: TextStyle(color: Color(0xFF80848E))),
        ],
      ),
    );
  }
}
