import 'package:flutter/material.dart';

class ProfilePanel extends StatelessWidget {
  final String userId;

  const ProfilePanel({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      decoration: const BoxDecoration(
        color: Color(0xFF2B2D31),
        border: Border(
          left: BorderSide(color: Color(0xFF1E1F22), width: 1.5),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Banner + Avatar Stack ──
            Stack(
              clipBehavior: Clip.none,
              children: [
                // Banner
                Container(
                  height: 80,
                  color: const Color(0xFF5865F2),
                ),

                // ✅ Avatar — banner ke neeche overlap
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

            // ✅ Avatar ke liye space
            const SizedBox(height: 48),

            // ── Content ──
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Username',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'username',
                    style: TextStyle(
                      color: Color(0xFF80848E),
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Divider(color: Color(0xFF1E1F22)),
                  const SizedBox(height: 8),
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
            ),
          ],
        ),
      ),
    );
  }
}
