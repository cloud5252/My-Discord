// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:my_discord/ui/common/hover_builder.dart';
import 'package:my_discord/ui/views/log_in/widget/privacy_check_or_rich_text.dart';
import 'package:my_discord/ui/views/log_in/widget/signUp_button.dart';
import 'package:my_discord/ui/views/log_in/widget/signUp_dropdown.dart';
import 'package:my_discord/ui/views/log_in/widget/signUp_textfield.dart';
import 'package:stacked/stacked.dart';
import 'package:my_discord/ui/views/log_in/signUp_viewModel.dart';
import 'package:my_discord/ui/views/log_in/widget/signUp_label.dart';

class SignupView extends StackedView<SignupViewmodel> {
  final VoidCallback onSwitch;
  const SignupView({super.key, required this.onSwitch});

  @override
  SignupViewmodel viewModelBuilder(BuildContext context) => SignupViewmodel();

  @override
  Widget builder(
      BuildContext context, SignupViewmodel viewmodel, Widget? child) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        key: const Key('signupView'),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              'Create an account',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 24),
          const SignupLabel(
            text: 'Email ',
            staric: '*',
          ),
          const SizedBox(height: 8),
          SignupTextfield(
            controller: viewmodel.Emailcontroller,
            obsecurtext: false,
            hinttext: '',
            helpertext: '',
            isFocused: viewmodel.isEmailFocused,
            focusNode: viewmodel.emailFocus,
          ),
          const SizedBox(height: 16),
          const SignupLabel(
            text: 'Display Name',
            staric: '',
          ),
          const SizedBox(height: 8),
          SignupTextfield(
            controller: viewmodel.displaynamecontroller,
            obsecurtext: false,
            hinttext: '',
            helpertext:
                'This is how others see you. You can use special characters and emojis',
            focusNode: viewmodel.displaynameFocus,
            isFocused: viewmodel.isDisplaynameFocused,
          ),
          const SizedBox(height: 16),
          const SignupLabel(
            text: 'Username ',
            staric: '*',
          ),
          const SizedBox(height: 8),
          SignupTextfield(
            controller: viewmodel.usernamecontroller,
            obsecurtext: false,
            hinttext: '',
            helpertext:
                'Please only use letters, numbers, underscores _, or periods.',
            focusNode: viewmodel.usernameFocus,
            isFocused: viewmodel.isUsernameFocused,
          ),
          const SizedBox(height: 16),
          const SignupLabel(
            text: 'Password ',
            staric: '*',
          ),
          const SizedBox(height: 8),
          SignupTextfield(
            controller: viewmodel.passwordcontroller,
            obsecurtext: true,
            hinttext: '',
            helpertext: '',
            isFocused: viewmodel.isPasswordFocused,
            focusNode: viewmodel.passwordFocus,
          ),
          const SizedBox(height: 16),
          const SignupLabel(
            text: 'Date of Birth ',
            staric: '*',
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: SignupDropdown(
                  hint: 'Month',
                  items: viewmodel.monthItems,
                  type: 'month',
                  selected: viewmodel.selectedMonth,
                  isOpen: viewmodel.isMonthOpen,
                  layerLink: viewmodel.monthLink,
                  onToggle: viewmodel.toggleDropdown,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: SignupDropdown(
                  hint: 'Day',
                  items: viewmodel.dayItems,
                  type: 'day',
                  selected: viewmodel.selectedDay,
                  isOpen: viewmodel.isDayOpen,
                  layerLink: viewmodel.dayLink,
                  onToggle: viewmodel.toggleDropdown,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: SignupDropdown(
                  hint: 'Year',
                  items: viewmodel.yearItems,
                  type: 'year',
                  selected: viewmodel.selectedYear,
                  isOpen: viewmodel.isYearOpen,
                  layerLink: viewmodel.yearLink,
                  onToggle: viewmodel.toggleDropdown,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          PrivacyCheckOrRichText(viewModel: viewmodel),
          const SizedBox(height: 20),
          SignupButton(
            text: 'Create Account',
            ontap: () => viewmodel.register(),
            isBusy: viewmodel.isBusy,
            isEnabled: viewmodel.isTermsAccepted,
          ),
          const SizedBox(height: 12),
          HoverBuilder(
            builder: (isHovered) => GestureDetector(
              onTap: onSwitch,
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Text(
                  'Already have an account? Sign in',
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
  }
}
