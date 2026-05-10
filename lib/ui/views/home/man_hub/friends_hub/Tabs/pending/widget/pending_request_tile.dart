import 'package:flutter/material.dart';

class PendingRequestTile extends StatelessWidget {
  final Map<String, dynamic> request;
  final bool isIncoming;
  final Function(String docId, String fromUid)? onAccept;
  final Function(String docId)? onReject;
  final Function(String docId)? onCancel;

  const PendingRequestTile({
    Key? key,
    required this.request,
    required this.isIncoming,
    this.onAccept,
    this.onReject,
    this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String docId = request['id'] ?? '';
    final String fromUid = request['fromUid'] ?? '';
    final String name = isIncoming
        ? (request['fromName'] ?? 'Unknown')
        : (request['toName'] ?? 'Unknown');
    final String? photo =
        isIncoming ? request['fromPhoto'] : request['toPhoto'];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Colors.transparent,
      ),
      child: Row(
        children: [
          // Avatar
          CircleAvatar(
            radius: 20,
            backgroundColor: const Color(0xFF5865F2),
            backgroundImage:
                photo != null && photo.isNotEmpty ? NetworkImage(photo) : null,
            child: photo == null || photo.isEmpty
                ? Text(
                    name[0].toUpperCase(),
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )
                : null,
          ),
          const SizedBox(width: 12),

          // Name + label
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: const TextStyle(
                        color: Color(0xFFDBDEE1),
                        fontSize: 14,
                        fontWeight: FontWeight.w600)),
                Text(
                  isIncoming
                      ? 'Incoming Friend Request'
                      : 'Outgoing Friend Request',
                  style:
                      const TextStyle(color: Color(0xFF80848E), fontSize: 12),
                ),
              ],
            ),
          ),

          // Action buttons
          if (isIncoming) ...[
            _ActionButton(
              icon: Icons.check,
              color: const Color(0xFF3BA55C),
              tooltip: 'Accept',
              onTap: () => onAccept?.call(docId, fromUid),
            ),
            const SizedBox(width: 8),
            _ActionButton(
              icon: Icons.close,
              color: const Color(0xFFED4245),
              tooltip: 'Reject',
              onTap: () => onReject?.call(docId),
            ),
          ] else
            _ActionButton(
              icon: Icons.close,
              color: const Color(0xFF80848E),
              tooltip: 'Cancel',
              onTap: () => onCancel?.call(docId),
            ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String tooltip;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.color,
    required this.tooltip,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 32,
          height: 32,
          decoration: const BoxDecoration(
            color: Color(0xFF2B2D31),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 16),
        ),
      ),
    );
  }
}
