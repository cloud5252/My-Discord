import 'package:flutter/material.dart';
import 'package:my_discord/ui/common/app_colors.dart';

class LoginTextfield extends StatelessWidget {
  final String hinttext;
  final String helpertext;
  final bool obsecurtext;
  final bool isFocused;
  final FocusNode focusNode;
  final TextEditingController controller;

  const LoginTextfield({
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
    final bool showHelper = isFocused && helpertext.isNotEmpty;

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
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, -0.3),
                    end: Offset.zero,
                  ).animate(CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOut,
                  )),
                  child: child,
                ),
              );
            },
            child: showHelper
                ? Padding(
                    key: const ValueKey('shown'),
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      helpertext,
                      style: const TextStyle(
                        color: Color(0xFFB5BAC1),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                : const SizedBox(
                    key: ValueKey('hidden'),
                    height: 0,
                    width: double.infinity,
                  ),
          ),
        ),
      ],
    );
  }
}
