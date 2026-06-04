// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:my_discord/ui/views/auth_view/auth_view_model.dart';
import 'package:my_discord/ui/views/log_in/signUp_view.dart';
import 'package:my_discord/ui/views/sign_in/sign_in_view.dart';
import 'package:stacked/stacked.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AuthViewModel>.reactive(
      viewModelBuilder: () => AuthViewModel(),
      builder: (context, viewmodel, child) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF1e1f7b),
                  Color(0xFF5865f2),
                  Color(0xFF3b1f8c),
                  Color(0xFF1a1b2e),
                ],
                stops: [0.0, 0.4, 0.7, 1.0],
              ),
            ),
            child: Stack(
              children: [
                const Positioned(
                  top: 20,
                  left: 20,
                  child: Row(
                    children: [
                      Icon(
                        Icons.discord,
                        color: Colors.white,
                        size: 35,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Discord',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Container(
                    width: 480,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2B2D31),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: viewmodel.isRegisterMode
                          ? SignupView(
                              key: const ValueKey('signup_page'),
                              onSwitch: viewmodel.toggleMode,
                            )
                          : SignInView(
                              key: const ValueKey('signin_page'),
                              onSwitch: viewmodel.toggleMode,
                            ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
