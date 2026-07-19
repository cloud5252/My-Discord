// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:my_discord/ui/common/discord_tool_tip_extension.dart';

class UserOnlineTile extends StatelessWidget {
  final String text;
  final String status;
  final void Function()? ontap;
  final _hovered = ValueNotifier<bool>(false);

  UserOnlineTile({
    super.key,
    required this.text,
    this.status = 'offline',
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _hovered.value = true,
      onExit: (_) => _hovered.value = false,
      child: ValueListenableBuilder<bool>(
        valueListenable: _hovered,
        builder: (context, isHovered, child) {
          return GestureDetector(
            onTap: ontap,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  height: 0.5,
                  color: const Color(0xFF3F4147).withOpacity(0.4),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: isHovered
                        ? const Color(0xFF333338).withOpacity(0.22)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          const CircleAvatar(
                            radius: 19,
                            backgroundColor: Color(0xFF80848E),
                            child: Icon(Icons.discord,
                                color: Colors.white, size: 22),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              height: 12,
                              width: 12,
                              decoration: BoxDecoration(
                                color: status.toLowerCase() == 'online'
                                    ? const Color(0xFF23A55A)
                                    : const Color(0xFF80848E),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isHovered
                                      ? const Color(0xFF35373C)
                                      : const Color(0xFF1a1a1e),
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              text,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFFF2F3F5),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              status[0].toUpperCase() + status.substring(1),
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFF949BA4),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildActionButton(Icons.chat_bubble, isHovered, () {
                            if (ontap != null) ontap!();
                          }).withDiscordTooltip('Message'),
                          const SizedBox(width: 8),
                          _buildActionButton(Icons.more_vert, isHovered, () {})
                              .withDiscordTooltip('More'),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildActionButton(
      IconData icon, bool isHovered, VoidCallback action) {
    return GestureDetector(
      onTap: action,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isHovered ? const Color(0xFF121214) : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: const Color(0xFFB5BAC1),
          size: 18,
        ),
      ),
    );
  }
}
