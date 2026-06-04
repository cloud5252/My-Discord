// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:my_discord/ui/common/hover_builder.dart';
import 'package:my_discord/ui/views/sign_in/widget/sign_in_label.dart';
import 'package:my_discord/ui/views/sign_in/widget/sign_in_textfield.dart';
import 'package:stacked/stacked.dart';
import 'package:my_discord/ui/views/sign_in/sign_in_viewModel.dart';
import 'package:my_discord/ui/views/sign_in/widget/sigin_button.dart';

class SignInView extends StatelessWidget {
  final VoidCallback onSwitch;
  const SignInView({super.key, required this.onSwitch});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SigInViewModel>.reactive(
      viewModelBuilder: () => SigInViewModel(),
      builder: (context, viewmodel, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            key: const Key('signInView'),
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'Welcome back!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Center(
                child: Text(
                  "We're so excited to see you again!",
                  style: TextStyle(
                    color: Color(0xFFB5BAC1),
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const SignInLabel(text: 'Email or Phone Number ', staric: '*'),
              const SizedBox(height: 8),
              SignInTextfield(
                controller: viewmodel.emailcontroller,
                obsecurtext: false,
                hinttext: '',
                helpertext: '',
                isFocused: viewmodel.isEmailFocused,
                focusNode: viewmodel.emailFocusNode,
              ),
              const SizedBox(height: 16),
              const SignInLabel(text: 'Password ', staric: '*'),
              const SizedBox(height: 8),
              SignInTextfield(
                controller: viewmodel.passwordcontroller,
                obsecurtext: true,
                hinttext: '',
                helpertext: '',
                isFocused: viewmodel.isPasswordFocused,
                focusNode: viewmodel.passwordFocusNode,
              ),
              const SizedBox(height: 8),
              const Text(
                'Forgot your password?',
                style: TextStyle(
                  color: Color(0xFF00A8FC),
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 44,
                child: SiginButton(
                  ontap: viewmodel.signIn,
                  text: 'Sign In',
                  isBusy: viewmodel.isBusy,
                ),
              ),
              const SizedBox(height: 8),
              HoverBuilder(
                builder: (isHovered) => GestureDetector(
                  onTap: onSwitch,
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Text(
                      "Need an account? Register",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 13,
                        decoration: isHovered
                            ? TextDecoration.underline
                            : TextDecoration.none,
                        decorationColor: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
