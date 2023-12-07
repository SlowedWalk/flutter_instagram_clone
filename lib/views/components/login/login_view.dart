import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/auth/providers/auth_state_provider.dart';
import 'package:instagram_clone/views/components/constants/app_colors.dart';
import 'package:instagram_clone/views/components/constants/strings.dart';
import 'package:instagram_clone/views/components/login/divider_with_margin.dart';
import 'package:instagram_clone/views/components/login/google_button.dart';
import 'package:instagram_clone/views/components/login/login_view_signup_links.dart';

class LoginView extends ConsumerWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(Strings.appName),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),
                Text(
                  Strings.welcomeToApp,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const DividerWithMargin(),
                Text(
                  Strings.logIntoYourAccount,
                  style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(height: 1.5),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: ref.read(authStateProvider.notifier).loginWithGoogle,
                  style: TextButton.styleFrom(
                    backgroundColor: AppColors.loginButtonColor,
                    foregroundColor: AppColors.loginButtonTextColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const GoogleButton(),
                ),
                const DividerWithMargin(),
                const LoginViewSignupLink()
              ],
            ),
          ),
        ));
  }
}
