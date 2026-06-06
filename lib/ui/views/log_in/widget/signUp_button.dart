// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:my_discord/ui/common/app_colors.dart';
import 'package:my_discord/ui/common/hover_builder.dart';
import 'package:my_discord/ui/views/log_in/widget/signUp_tool_tip.dart';

class SignupButton extends StatelessWidget {
  final String text;
  final void Function()? ontap;
  final bool isBusy;
  final bool isEnabled;
  const SignupButton({
    required this.ontap,
    required this.text,
    required this.isBusy,
    required this.isEnabled,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return HoverBuilder(
      builder: (isHovered) {
        return GestureDetector(
          onTap: isEnabled ? ontap : null,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: isEnabled
                  ? isHovered
                      ? loginButtonColor.withOpacity(0.85)
                      : loginButtonColor
                  : loginButtonColor.withOpacity(0.4),
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
                      style: TextStyle(
                        fontSize: 15,
                        color: isEnabled
                            ? Colors.white
                            : Colors.white.withOpacity(0.5),
                      ),
                    ),
            ),
          ),
        ).signUptooltip(
          !isEnabled
              ? '      You need agree to our \n terms of Service to continue'
              : '',
          preferBelow: false,
        );
      },
    );
  }
}
