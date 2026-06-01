import 'package:flutter/material.dart';

class SignInLabel extends StatelessWidget {
  final String text;
  final String staric;
  const SignInLabel({super.key, required this.text, required this.staric});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              text,
              style: const TextStyle(
                color: Color(0xFFB5BAC1),
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
            Text(
              staric,
              style: const TextStyle(
                color: Color(0xFFc98381),
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
