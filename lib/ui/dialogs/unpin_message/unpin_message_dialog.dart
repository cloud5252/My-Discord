// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:my_discord/models/messsage_model.dart';
import 'package:my_discord/ui/common/app_colors.dart';
import 'package:my_discord/ui/common/helper.dart';
import 'package:my_discord/ui/common/hover_builder.dart';
import 'package:my_discord/ui/common/ui_helpers.dart';
import 'package:my_discord/ui/dialogs/unpin_message/widget/dialog_action_button.dart';
import 'package:my_discord/ui/dialogs/unpin_message/unpin_message_dialog_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class UnpinMessageDialog extends StackedView<UnpinMessageDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const UnpinMessageDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    UnpinMessageDialogModel viewModel,
    Widget? child,
  ) {
    final message = request.data as MessageModel?;
    final screenSize = MediaQuery.of(context).size;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: backgroundDartMode,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: screenSize.width < 500 ? screenSize.width * 0.9 : 500,
          maxHeight: screenSize.height * 0.90,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        request.title ?? 'Unpin Message',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: whiteColor,
                        ),
                      ),
                    ),
                    HoverBuilder(
                      builder: (isHovered) => GestureDetector(
                        onTap: () =>
                            completer(DialogResponse(confirmed: false)),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: isHovered
                                ? Colors.white.withOpacity(0.09)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.close,
                            color: isHovered
                                ? Colors.white70
                                : const Color(0xFF80848E),
                            size: 22,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                verticalSpaceSmall,

                // Description
                Text(
                  request.description ??
                      'You sure you want to remove this pinned message?',
                  style: const TextStyle(
                    fontSize: 15,
                    color: Color(0xFFB5BAC1),
                    height: 1.4,
                  ),
                ),
                verticalSpaceMedium,

                // Message preview card
                if (message != null)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2B2D31),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.blue,
                          child:
                              Icon(Icons.person, color: Colors.white, size: 18),
                        ),
                        horizontalSpaceSmall,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Title row: naam + time
                              Row(
                                children: [
                                  Text(
                                    message.senderEmail ?? 'User',
                                    style: const TextStyle(
                                      color: whiteColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  horizontalSpaceTiny,
                                  Text(
                                    _formatTimestamp(message.timestamp),
                                    style: const TextStyle(
                                      color: Color(0xFF80848E),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              verticalSpaceTiny,

                              // Subtitle: message text (emoji ho to bada)
                              Text(
                                message.messageText ?? '',
                                style: TextStyle(
                                  color: const Color(0xFFDBDEE1),
                                  fontSize: getMessageFontSize(
                                      message.messageText ?? ''),
                                ),
                              ),

                              if (message.reactions.isNotEmpty) ...[
                                verticalSpaceTiny,
                                _buildReactionsPreview(message),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                verticalSpaceMedium,

                // PROTIP section
                RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFFB5BAC1),
                      height: 1.5,
                    ),
                    children: [
                      TextSpan(
                        text: 'PROTIP: ',
                        style: TextStyle(
                          color: Color(0xFF3BA55D),
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      TextSpan(text: 'You can hold down '),
                      TextSpan(
                        text: 'shift',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: ' when clicking '),
                      TextSpan(
                        text: 'unpin message',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: ' to bypass this confirmation entirely.'),
                    ],
                  ),
                ),

                verticalSpaceMedium,

                // Buttons
                Row(
                  children: [
                    Expanded(
                      child: DialogActionButton(
                        label: request.secondaryButtonTitle ?? 'Cancel',
                        backgroundColor: const Color(0xFF2B2D31),
                        onTap: () =>
                            completer(DialogResponse(confirmed: false)),
                      ),
                    ),
                    horizontalSpaceSmall,
                    Expanded(
                      child: DialogActionButton(
                        label: request.mainButtonTitle ?? 'Remove it please!',
                        backgroundColor: const Color(0xFFED4245),
                        fontWeight: FontWeight.w600,
                        onTap: () => completer(DialogResponse(confirmed: true)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatTimestamp(dynamic timestamp) {
    if (timestamp == null) return '';
    final dt =
        timestamp is DateTime ? timestamp : (timestamp as dynamic).toDate();
    final hour = dt.hour.toString().padLeft(2, '0');
    final min = dt.minute.toString().padLeft(2, '0');
    return '$hour:$min';
  }

  @override
  UnpinMessageDialogModel viewModelBuilder(BuildContext context) =>
      UnpinMessageDialogModel();
}

Widget _buildReactionsPreview(MessageModel message) {
  return Wrap(
    spacing: 6,
    runSpacing: 4,
    children: message.reactions.entries.map((entry) {
      final emoji = entry.key;
      final count = entry.value.length;

      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: const Color(0xFF2B2D31),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFF5865F2), width: 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 13)),
            const SizedBox(width: 4),
            Text(
              count.toString(),
              style: const TextStyle(
                color: Color(0xFF5865F2),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    }).toList(),
  );
}
