import 'package:flutter/material.dart';
import 'package:my_discord/ui/common/app_colors.dart';

class SiginButton extends StatelessWidget {
  final String text;
  final void Function()? ontap;
  const SiginButton({required this.ontap, required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: blueColor,
        ),
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Center(
            child: Text(
          text,
          style: const TextStyle(fontSize: 18, color: whiteColor),
        )),
      ),
    );
  }
}
