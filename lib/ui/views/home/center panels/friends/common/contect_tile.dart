import 'package:flutter/material.dart';
import 'package:my_discord/models/contect_model.dart';
import 'package:my_discord/ui/views/home/center%20panels/friends/fraind_hub_view_model.dart';

class ContactTile extends StatelessWidget {
  final ContactModel contact;
  final FraindHubViewModel viewModel;
  final bool dimmed;

  const ContactTile({
    Key? key,
    required this.contact,
    required this.viewModel,
    this.dimmed = false,
  }) : super(key: key);

  Color get _statusColor {
    return switch (contact.status) {
      'online' => const Color(0xFF3BA55C),
      'idle' => const Color(0xFFFAA61A),
      _ => const Color(0xFF747F8D),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: dimmed ? 0.55 : 1.0,
      child: InkWell(
        onTap: () => viewModel.navigateToChat(contact),
        borderRadius: BorderRadius.circular(6),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
          child: Row(
            children: [
              _Avatar(contact: contact, statusColor: _statusColor),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      contact.displayName,
                      style: const TextStyle(
                        color: Color(0xFFDCDDDE),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      contact.status,
                      style: const TextStyle(
                        color: Color(0xFF72767D),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              // Action buttons
              _ActionIcon(
                  icon: Icons.chat_bubble_outline,
                  onTap: () => viewModel.navigateToChat(contact)),
              const SizedBox(width: 8),
              _ActionIcon(icon: Icons.more_vert, onTap: () {}),
            ],
          ),
        ),
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  final ContactModel contact;
  final Color statusColor;

  const _Avatar({required this.contact, required this.statusColor});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: const Color(0xFF5865F2),
          backgroundImage:
              contact.photoUrl != null && contact.photoUrl!.isNotEmpty
                  ? NetworkImage(contact.photoUrl!)
                  : null,
          child: contact.photoUrl == null || contact.photoUrl!.isEmpty
              ? Text(
                  contact.displayName.isNotEmpty
                      ? contact.displayName[0].toUpperCase()
                      : '?',
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )
              : null,
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: statusColor,
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFF36393F), width: 2),
            ),
          ),
        ),
      ],
    );
  }
}

class _ActionIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _ActionIcon({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: const BoxDecoration(
          color: Color(0xFF202225),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: const Color(0xFFB9BBBE), size: 16),
      ),
    );
  }
}
