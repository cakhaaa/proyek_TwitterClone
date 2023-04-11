import 'package:flutter/material.dart';
import 'package:proyek/common/rounded_small_button.dart';
import 'package:proyek/constants/ui_constants.dart';
import 'package:proyek/features/auth/widget/auth_fild.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();

}

class _LoginViewState extends State<LoginView> {
  final appbar = UIConstants.appBar();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:appbar,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              // textfield 1
              AuthField(
                controller: emailController,  
                hintText: 'Email',
              ),
              const SizedBox(height: 25),
              AuthField(
                controller: passwordController, 
                hintText: 'Password',
              ),
              const SizedBox(height: 40),
              Align(
                alignment: Alignment.topRight,
                child: RoundedSmallButton(
                  onTap: () {}, 
                  label: 'Done',
                  ),
              ),
              // button
              //textspan
              ],
            ),
          ),
        ),
      ),
    );
  }
}