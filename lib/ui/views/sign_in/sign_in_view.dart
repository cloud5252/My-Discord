import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:my_discord/ui/views/sign_in/sign_in_viewModel.dart';
import 'package:my_discord/ui/views/sign_in/widget/sigin_button.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SigInViewModel>.reactive(
      viewModelBuilder: () => SigInViewModel(),
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
                    // Title
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

                    // Email field
                    const Text(
                      'Email or Phone Number',
                      style: TextStyle(
                        color: Color(0xFFB5BAC1),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      
                      controller: viewmodel.Emailcontroller,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFF1E1F22),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(
                            color: Color(0xFF5865F2),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Password field
                    const Text(
                      'Password *',
                      style: TextStyle(
                        color: Color(0xFFB5BAC1),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: viewmodel.passwordcontroller,
                      obscureText: true,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFF1E1F22),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(
                            color: Color(0xFF5865F2),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),

                    // Forgot password
                    const Text(
                      'Forgot your password?',
                      style: TextStyle(
                        color: Color(0xFF00A8FC),
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Login button
                    SizedBox(
                      width: double.infinity,
                      height: 44,
                      child:  SiginButton(ontap: viewmodel.signIn, text: 'Sign In')
                    ),
                    const SizedBox(height: 8),

                    // Register
                    Row(
                      children: [
                        const Text(
                          'Need an account? ',
                          style: TextStyle(
                            color: Color(0xFFB5BAC1),
                            fontSize: 13,
                          ),
                        ),
                        GestureDetector(
                          onTap: viewmodel.navigateToRegister,
                          child: const Text(
                            'Register',
                            style: TextStyle(
                              color: Color(0xFF00A8FC),
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
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