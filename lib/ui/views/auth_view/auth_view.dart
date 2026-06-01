// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:my_discord/service/auth_view_Model/auth_view_model.dart';
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
          body: Stack(
            children: [
              Positioned.fill(
                  child: Image.asset('assets/dc.jpg', fit: BoxFit.cover)),
              Positioned.fill(
                  child: Container(color: Colors.black.withOpacity(0.4))),
              Center(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  width: 480,
                  height: viewmodel.isRegisterMode ? 750 : 400,
                  // padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2B2D31),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    child: viewmodel.isRegisterMode
                        ? SignupView(onSwitch: viewmodel.toggleMode)
                        : SignInView(onSwitch: viewmodel.toggleMode),
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
