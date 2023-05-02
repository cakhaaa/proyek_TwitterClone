import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyek/common/loading_page.dart';
import 'package:proyek/constants/constants.dart';
import 'package:proyek/common/common.dart';
import 'package:proyek/features/auth/controller/auth_controller.dart';
import 'package:proyek/features/auth/view/login_view.dart';
import 'package:proyek/features/auth/widget/auth_fild.dart';
import 'package:proyek/theme/theme.dart';

class SignUpView extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => SignUpView(),
      );
  const SignUpView({super.key});

  @override
  ConsumerState<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends ConsumerState<SignUpView> {
 final appbar = UIConstants.appBar();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void onSignUp() {
    final res = ref.read(authControllerProvider.notifier).signUp(
      email: emailController.text,
      password: passwordController.text,
      context: context,
    );
  }

  @override
  Widget build (BuildContext context) {
    final isloading = ref.watch(authControllerProvider);
    return Scaffold(
      appBar: appbar,
      body: isloading 
      ? const Loader() : Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
            children: [
             //See
             const Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                "See What's Happening In The World Right Now",
                style: TextStyle(
                  color:Colors.white,
                  fontSize:30,
                ),
              ),
             ),
             
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
                  onTap: onSignUp, 
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