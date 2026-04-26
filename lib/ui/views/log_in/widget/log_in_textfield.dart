import 'package:flutter/material.dart';
import 'package:my_discord/ui/common/app_colors.dart';

class LoginTextfield extends StatelessWidget {
  final String hinttext;
  final bool obsecurtext;
  final TextEditingController controller;
  const LoginTextfield({
    required this.controller,
    required this.obsecurtext,
    required this.hinttext,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: blackColor,
      style: const TextStyle(fontSize: 18, color: whiteColor),
      controller: controller,
      obscureText: obsecurtext,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: greyColor,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: greyColor,
          ),
        ),
        fillColor: textfieldfilledColor,
        filled: true,
        hintText: hinttext,
        hintStyle: TextStyle(
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
    );
  }
}
