import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:my_discord/ui/views/log_in/log_in_viewModel.dart';
import 'package:my_discord/ui/views/log_in/widget/log_in_button.dart';
import 'package:my_discord/ui/views/log_in/widget/log_in_textfield.dart';
import 'package:my_discord/ui/views/log_in/widget/login_dropdown.dart';
import 'package:my_discord/ui/views/log_in/widget/login_label.dart';

class LogInView extends StatelessWidget {
  const LogInView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LogInViewModel>.reactive(
      viewModelBuilder: () => LogInViewModel(),
      builder: (context, viewmodel, child) {
        return Scaffold(
          backgroundColor: const Color(0xFF313338),
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
                    ),
                    const SizedBox(height: 16),
                    const LoginLabel(text: 'Display Name'),
                    const SizedBox(height: 8),
                    LoginTextfield(
                      controller: viewmodel.displaynamecontroller,
                      obsecurtext: false,
                      hinttext: '',
                    ),
                    const SizedBox(height: 16),
                    const LoginLabel(text: 'Username *'),
                    const SizedBox(height: 8),
                    LoginTextfield(
                      controller: viewmodel.usernamecontroller,
                      obsecurtext: false,
                      hinttext: '',
                    ),
                    const SizedBox(height: 16),
                    const LoginLabel(text: 'Password *'),
                    const SizedBox(height: 8),
                    LoginTextfield(
                      controller: viewmodel.passwordcontroller,
                      obsecurtext: false,
                      hinttext: '',
                    ),
                    const SizedBox(height: 16),
                    const LoginLabel(text: 'Date of Birth *'),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Expanded(
                          child: LoginDropdown(
                            hint: 'Month',
                            items: [
                              'January',
                              'February',
                              'March',
                              'April',
                              'May',
                              'June',
                              'July',
                              'August',
                              'September',
                              'October',
                              'November',
                              'December'
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: LoginDropdown(
                            hint: 'Day',
                            items: List.generate(31, (i) => '${i + 1}'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: LoginDropdown(
                            hint: 'Year',
                            items: List.generate(100, (i) => '${2024 - i}'),
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
      },
    );
  }
}
