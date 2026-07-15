import 'package:flutter/material.dart';

class ProfilePanel extends StatelessWidget {
  final String userId;

  const ProfilePanel({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340,
      height: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border(
          left: BorderSide(color: Colors.grey.shade700, width: 0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 80,
                color: const Color(0xFF5865F2),
              ),
              Positioned(
                top: 44,
                left: 16,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF2B2D31),
                      width: 4,
                    ),
                  ),
                  child: const CircleAvatar(
                    radius: 36,
                    backgroundColor: Color(0xFF5865F2),
                    child: Icon(Icons.person, color: Colors.white, size: 36),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 48),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Username',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'username',
                  style: TextStyle(
                    color: Color(0xFF80848E),
                    fontSize: 13,
                  ),
                ),
                SizedBox(height: 12),
                Divider(color: Color(0xFF1E1F22)),
                SizedBox(height: 8),
              ],
            ),
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5865F2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              onPressed: () {},
              child: const Text(
                'Message',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
