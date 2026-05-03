import 'package:flutter/material.dart';

class ServerSidebar extends StatelessWidget {
  const ServerSidebar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF121214), // Darkest black color
      child: Column(
        children: [
          const SizedBox(height: 12),
          // Discord Icon at the top
          Container(
            height: 40,
            width: 40,
            decoration: const BoxDecoration(
              color: Color(0xFF121214),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.discord, color: Colors.white, size: 30),
          ),
          const SizedBox(height: 12),
          // Placeholder for Servers (Circle Icons)
          Expanded(
            child: ListView.separated(
              itemCount: 3,
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                return Center(
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: const BoxDecoration(
                      color: Color(0xFF36373D),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                        child: Text('${index + 1}',
                            style: const TextStyle(color: Colors.white))),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
