import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:locally/common/helper/navigator/app_navigator.dart';
import 'package:locally/common/widgets/button/basic_app_button.dart';
import 'package:locally/core/configs/assets/app_vectors.dart';
import 'package:locally/presentation/auth/pages/signin.dart';

class PasswordResetEmailPage extends StatelessWidget {
  const PasswordResetEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _emailSending(),
                const SizedBox(height: 30),
                _sentEmail(),
                const SizedBox(height: 40),
                _returnToLoginButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _emailSending() {
    return SvgPicture.asset(
      AppVectors.emailSending,
      height: 200,
    );
  }

  Widget _sentEmail() {
    return const Text(
      'We’ve sent you an email with a link to reset your password.\nPlease check your inbox.',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 16,
        height: 1.5,
      ),
    );
  }

  Widget _returnToLoginButton(BuildContext context) {
    return BasicAppButton(
      onPressed: () {
        AppNavigator.pushReplacement(context, const SigninPage());
      },
      width: 200,
      title: 'Return to Login',
    );
  }
}
