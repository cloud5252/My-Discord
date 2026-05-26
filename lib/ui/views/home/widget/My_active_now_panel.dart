import 'package:flutter/material.dart';

class ActiveNowPanel extends StatelessWidget {
  const ActiveNowPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      decoration: const BoxDecoration(
        color: Color(0xFF1a1a1e),
        border: Border(
          left: BorderSide(color: Color(0xFF1E1F22), width: 1.5),
        ),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 12),
            child: Text(
              'Active Now',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          _ActiveNowTile(
            name: 'Moyo',
            activity: 'Watching YouTube',
            activityColor: Color(0xFFFF0000),
          ),
          _ActiveNowTile(
            name: 'z8ReapeR',
            activity: 'Forza Horizon 5 – 12h',
            activityColor: Color(0xFF3BA55C),
          ),
        ],
      ),
    );
  }
}

class _ActiveNowTile extends StatelessWidget {
  final String name;
  final String activity;
  final Color activityColor;

  const _ActiveNowTile({
    Key? key,
    required this.name,
    required this.activity,
    required this.activityColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF232428),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: const Color(0xFF5865F2),
                child: Text(
                  name[0].toUpperCase(),
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: const Color(0xFF3BA55C),
                    shape: BoxShape.circle,
                    border:
                        Border.all(color: const Color(0xFF232428), width: 2),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: activityColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        activity,
                        style: const TextStyle(
                            color: Color(0xFF80848E), fontSize: 11),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
