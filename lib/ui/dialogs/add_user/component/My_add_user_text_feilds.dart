import 'package:flutter/material.dart';
import 'package:my_discord/ui/common/app_colors.dart';

class MyAddUserTextFeilds extends StatelessWidget {
  final String hinttext;
  final bool obsecurtext;
  final TextEditingController controller;
  const MyAddUserTextFeilds({
    required this.controller,
    required this.obsecurtext,
    required this.hinttext,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(),
      child: TextField(
        style: const TextStyle(fontSize: 16, color: blackColor),
        cursorColor: blackColor,
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
          fillColor: whiteColor,
          filled: true,
          hintText: hinttext,
          hintStyle: const TextStyle(
            color: blackColor,
          ),
        ),
      ),
    );
  }
}
