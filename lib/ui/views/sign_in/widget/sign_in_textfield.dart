import 'package:flutter/material.dart';
import 'package:my_discord/ui/common/app_colors.dart';

class SignInTextfield extends StatelessWidget {
  final String hinttext;
  final String helpertext;
  final bool obsecurtext;
  final bool isFocused;
  final FocusNode focusNode;
  final TextEditingController controller;

  const SignInTextfield({
    required this.controller,
    required this.obsecurtext,
    required this.hinttext,
    required this.helpertext,
    required this.isFocused,
    required this.focusNode,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          focusNode: focusNode,
          cursorWidth: 1,
          cursorHeight: 20,
          cursorColor: whiteColor,
          style: const TextStyle(fontSize: 18, color: whiteColor),
          controller: controller,
          obscureText: obsecurtext,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            hoverColor: Colors.transparent,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: greyColor),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: focusBordercolor,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            fillColor: textfieldfilledColor,
            filled: true,
            hintText: hinttext,
            hintStyle: TextStyle(
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          child: isFocused && helpertext.isNotEmpty
              ? TweenAnimationBuilder<double>(
                  key: ValueKey(isFocused),
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 600),
                  builder: (context, value, child) => Opacity(
                    opacity: value,
                    child: Transform.translate(
                      offset: Offset(0, (1 - value) * 10),
                      child: child,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      helpertext,
                      style: const TextStyle(
                        color: Color(0xFFB5BAC1),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
