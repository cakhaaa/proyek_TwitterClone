import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:proyek/constants/constants.dart';
import 'package:proyek/common/common.dart';
import 'package:proyek/features/auth/view/login_view.dart';
import 'package:proyek/theme/theme.dart';

import '../widget/auth_fild.dart';
class SignUpView extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => SignUpView(),
      );
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
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
  Widget build (BuildContext context) {
    return Scaffold(
      appBar: appbar,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
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
              const SizedBox(height: 40),
              RichText(text: TextSpan(
                text : "Already an account?",
                style: const TextStyle( 
                      fontSize: 16,
                      ),
                children: [
                  TextSpan(
                    text: ' LogIn',
                    style: const TextStyle( 
                      color: Pallete.redColor,
                      fontSize: 16,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = () {
                        Navigator.push(
                          context, 
                          LoginView.route(),
                        );
                      },
                    ),
                  ],
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