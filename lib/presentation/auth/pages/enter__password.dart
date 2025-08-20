import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locally/common/bloc/button/button_state.dart';
import 'package:locally/common/bloc/button/button_state_cubit.dart';
import 'package:locally/common/helper/navigator/app_navigator.dart';
import 'package:locally/common/widgets/appbar/app_bar.dart';
import 'package:locally/common/widgets/button/basic_app_button.dart';
import 'package:locally/core/configs/theme/app_colors.dart';
import 'package:locally/data/auth/models/user_signin_req.dart';
import 'package:locally/domain/auth/usecases/siginin.dart';
import 'package:locally/presentation/auth/pages/forgot_password.dart';
import 'package:locally/presentation/navigation/pages/main_navigation.dart';

class EnterPasswordPage extends StatefulWidget {
  final UserSigninReq signinReq;

  const EnterPasswordPage({required this.signinReq, super.key});

  @override
  State<EnterPasswordPage> createState() => _EnterPasswordPageState();
}

class _EnterPasswordPageState extends State<EnterPasswordPage> {
  final TextEditingController _passwordCon = TextEditingController();

  @override
  void dispose() {
    _passwordCon.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 27, vertical: 15),
          child: BlocProvider(
            create: (context) => ButtonStateCubit(),
            child: BlocListener<ButtonStateCubit, ButtonState>(
              listener: (context, state) {
                if (state is ButtonFailureState) {
                  final snackbar = SnackBar(
                    content: Text(state.errorMessage),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.red,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackbar);
                } else if (state is ButtonSuccessState) {
                  AppNavigator.pushAndRemove(context,  MainNavigation());
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _signinText(),
                  const SizedBox(height: 24),
                  _passwordField(),
                  const SizedBox(height: 24),
                  _continueButton(),
                  const SizedBox(height: 16),
                  _forgotPasswordText(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _signinText() {
    return const Text(
      'Sign in',
      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.text),
    );
  }

  bool _obscurePassword = true;

  Widget _passwordField() {
    return TextField(
      controller: _passwordCon,
      obscureText: _obscurePassword,
      style: const TextStyle(color: AppColors.text),
      decoration: InputDecoration(
        hintText: 'Enter Password',
        border: const OutlineInputBorder(),
        suffixIcon: IconButton(
          icon: Icon(
            _obscurePassword ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: () {
            setState(() {
              _obscurePassword = !_obscurePassword;
            });
          },
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary),
        ),
      ),
    );
  }

  Widget _continueButton() {
    return Builder(
      builder: (context) {
        return BasicAppButton(
          onPressed: () {
            final password = _passwordCon.text.trim();

            if (password.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Please enter your password'),
                ),
              );
              return;
            }

            final updatedReq = widget.signinReq..password = password;

            context.read<ButtonStateCubit>().execute(
              usecase: SignInUseCase(),
              params: updatedReq,
            );
          },
          title: 'Continue',
        );
      },
    );
  }

  Widget _forgotPasswordText() {
    return RichText(
      text: TextSpan(
        style: const TextStyle(color: AppColors.text),
        children: [
          const TextSpan(text: "Forgot password?"),
          TextSpan(
            text: ' Reset',
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                AppNavigator.push(context, ForgotPasswordPage());
              },
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
