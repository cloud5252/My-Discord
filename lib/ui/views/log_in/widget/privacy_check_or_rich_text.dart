import 'package:flutter/material.dart';
import 'package:my_discord/ui/common/hover_builder.dart';
import 'package:my_discord/ui/views/log_in/signUp_viewModel.dart';
import 'package:my_discord/ui/views/log_in/widget/custom_check_box.dart';

class PrivacyCheckOrRichText extends StatelessWidget {
  final SignupViewmodel viewModel;
  const PrivacyCheckOrRichText({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: CustomCheckbox(
                value: viewModel.isEmailOptIn,
                onChanged: viewModel.toggleEmailOptIn,
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                '(Optional) It\'s ok to send me emails with Discord updates, tips, and special offers. You can opt out at any time.',
                style: TextStyle(
                  color: Color(0xFFB5BAC1),
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        RichText(
          text: TextSpan(
            style: const TextStyle(
              color: Color(0xFFB5BAC1),
              fontSize: 12,
            ),
            children: [
              const TextSpan(
                text: 'By clicking "Create Account", you agree to Discord\'s ',
              ),
              WidgetSpan(
                child: HoverBuilder(
                  builder: (isHovered) => MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Text(
                      'Terms of Service',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        decoration: isHovered
                            ? TextDecoration.underline
                            : TextDecoration.none,
                        decorationColor: Colors.blue,
                        decorationThickness: 1.5,
                      ),
                    ),
                  ),
                ),
              ),
              const TextSpan(text: ' and have read our '),
              WidgetSpan(
                child: HoverBuilder(
                  builder: (isHovered) => MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Text(
                      'Privacy Policy',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        decoration: isHovered
                            ? TextDecoration.underline
                            : TextDecoration.none,
                        decorationColor: Colors.blue,
                        decorationThickness: 1.5,
                      ),
                    ),
                  ),
                ),
              ),
              const TextSpan(text: '.'),
            ],
          ),
        ),
      ],
    );
  }
}
