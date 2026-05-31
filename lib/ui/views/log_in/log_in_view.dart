import 'package:flutter/material.dart';
import 'package:my_discord/ui/views/log_in/widget/login_dropdown.dart';
import 'package:stacked/stacked.dart';
import 'package:my_discord/ui/views/log_in/log_in_viewModel.dart';
import 'package:my_discord/ui/views/log_in/widget/log_in_button.dart';
import 'package:my_discord/ui/views/log_in/widget/log_in_textfield.dart';
import 'package:my_discord/ui/views/log_in/widget/login_label.dart';

class LogInView extends StackedView<LogInViewModel> {
  const LogInView({super.key});

  @override
  LogInViewModel viewModelBuilder(BuildContext context) => LogInViewModel();

  @override
  Widget builder(
      BuildContext context, LogInViewModel viewmodel, Widget? child) {
    return Scaffold(
      backgroundColor: const Color(0xFF393a41),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 480,
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: const Color(0xFF2B2D31),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
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
                const LoginLabel(text: 'Email *'),
                const SizedBox(height: 8),
                LoginTextfield(
                  controller: viewmodel.Emailcontroller,
                  obsecurtext: false,
                  hinttext: '',
                  helpertext: '',
                  isFocused: viewmodel.isEmailFocused,
                  focusNode: viewmodel.emailFocus,
                ),
                const SizedBox(height: 16),
                const LoginLabel(text: 'Display Name'),
                const SizedBox(height: 8),
                LoginTextfield(
                  controller: viewmodel.displaynamecontroller,
                  obsecurtext: false,
                  hinttext: '',
                  helpertext:
                      'This is how others see you. You can use special characters and emojis',
                  focusNode: viewmodel.displaynameFocus,
                  isFocused: viewmodel.isDisplaynameFocused,
                ),
                const SizedBox(height: 16),
                const LoginLabel(text: 'Username *'),
                const SizedBox(height: 8),
                LoginTextfield(
                  controller: viewmodel.usernamecontroller,
                  obsecurtext: false,
                  hinttext: '',
                  helpertext:
                      'Please only use letters, numbers, underscores _, or periods.',
                  focusNode: viewmodel.usernameFocus,
                  isFocused: viewmodel.isUsernameFocused,
                ),
                const SizedBox(height: 16),
                const LoginLabel(text: 'Password *'),
                const SizedBox(height: 8),
                LoginTextfield(
                  controller: viewmodel.passwordcontroller,
                  obsecurtext: true,
                  hinttext: '',
                  helpertext: '',
                  isFocused: viewmodel.isPasswordFocused,
                  focusNode: viewmodel.passwordFocus,
                ),
                const SizedBox(height: 16),
                const LoginLabel(text: 'Date of Birth *'),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: LoginDropdown(
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
                      child: LoginDropdown(
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
                      child: LoginDropdown(
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
                LoginButton(
                  text: 'Create Account',
                  ontap: () => viewmodel.register(),
                  isBusy: viewmodel.isBusy,
                ),
                const SizedBox(height: 12),
                GestureDetector(
                  onTap: viewmodel.navigateToLogin,
                  child: const Text(
                    'Already have an account? Log in',
                    style: TextStyle(
                      color: Color(0xFF00A8FC),
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
