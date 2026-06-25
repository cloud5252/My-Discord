import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_discord/models/messsage_model.dart';
import 'package:my_discord/ui/views/home/man_hub/chat/widget/message_bubble_widget.dart';

void main() {
  testWidgets('MessageBubbleWidget shows message text', (tester) async {
    final message = MessageModel(
      firebaseId: '1',
      chatRoomId: 'room1',
      senderId: 'uid1',
      senderEmail: 'test@example.com',
      receiverId: 'uid2',
      messageText: 'Hello World',
      timestamp: DateTime.now(),
      isRead: 0,
      isVoiceMessage: false,
      profileUrl: '',
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: MessageBubbleWidget(message: message)),
      ),
    );

    expect(find.text('Hello World'), findsOneWidget);
  });
}
