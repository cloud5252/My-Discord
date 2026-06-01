import 'package:flutter/material.dart';
import 'package:my_discord/ui/common/app_colors.dart';

class SiginButton extends StatelessWidget {
  final String text;
  final void Function()? ontap;
  final bool isBusy;
  const SiginButton({
    required this.ontap,
    required this.text,
    required this.isBusy,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: loginButtonColor,
        ),
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(horizontal: 1),
        child: Center(
          child: isBusy
              ? const SizedBox(
                  height: 18,
                  width: 18,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
              : Text(
                  text,
                  style: const TextStyle(fontSize: 15),
                ),
        ),
      ),
    );
  }
}
