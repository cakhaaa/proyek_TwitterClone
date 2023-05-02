import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyek/common/error_page.dart';
import 'package:proyek/common/loading_page.dart';
import 'package:proyek/features/auth/controller/auth_controller.dart';
import 'package:proyek/features/auth/view/signup_view.dart';
import 'package:proyek/features/home/view/home_view.dart';
import 'package:proyek/theme/app_theme.dart';

void main() {
  runApp(
    const ProviderScope(
      child: const MyApp()
      )
    );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'twitterz',
      theme: AppTheme.theme,
      home: ref.watch(currentUserAccountProvider).when(
        data: (user) {
          if (user != null) {
            return const HomeView();
          }
          return const SignUpView();
        },
        error: (error, st) => ErrorPage(
          error: error.toString()
          ),
        loading: () => const LoadingPage(),
        ) 
      ); 
  }
}
