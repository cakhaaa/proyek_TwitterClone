import 'package:flutter/material.dart';
import 'package:proyek/features/auth/view/signup_view.dart';
import 'package:proyek/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'twitterz',
      theme: AppTheme.theme,
      home: const SignUpView(),
    );
  }
}