import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:locally/common/helper/navigator/app_navigator.dart';
import 'package:locally/common/widgets/button/basic_app_button.dart';
import 'package:locally/core/configs/theme/app_colors.dart';
import 'package:locally/data/auth/models/user_signin_req.dart';
import 'package:locally/presentation/auth/pages/enter__password.dart';
import 'package:locally/presentation/auth/pages/signup.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final TextEditingController _emailCon = TextEditingController();

  @override
  void dispose() {
    _emailCon.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 27, vertical: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _siginText(),
              const SizedBox(height: 24),
              _emailField(),
              const SizedBox(height: 24),
              _continueButton(),
              const SizedBox(height: 16),
              _createAccount(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _siginText() {
    return const Text(
      'Sign in',
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: AppColors.text,
      ),
    );
  }

  Widget _emailField() {
    return TextField(
      controller: _emailCon,
      style: TextStyle(
        color: AppColors.text,
      ),
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        hintText: 'Enter Email',
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary),
        ),
      ),
    );
  }

  Widget _continueButton() {
    return BasicAppButton(
      onPressed: () {
        final email = _emailCon.text.trim();
        if (email.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please enter your email')),
          );
          return;
        }

        AppNavigator.push(
          context,
          EnterPasswordPage(
            signinReq: UserSigninReq(email: email),
          ),
        );
      },
      title: 'Continue',
    );
  }

  Widget _createAccount() {
    return RichText(
      text: TextSpan(
        style: const TextStyle(color: AppColors.text),
        children: [
          const TextSpan(text: "Don't have an account? "),
          TextSpan(
            text: 'Create one',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                AppNavigator.push(context, SignupPage());
              },
          ),
        ],
      ),
    );
  }
}
