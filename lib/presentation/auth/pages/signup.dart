import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locally/common/bloc/button/button_state_cubit.dart';
import 'package:locally/common/helper/navigator/app_navigator.dart';
import 'package:locally/common/widgets/button/basic_app_button.dart';
import 'package:locally/core/configs/theme/app_colors.dart';
import 'package:locally/data/auth/models/user_creation_req.dart';
import 'package:locally/presentation/auth/bloc/age_selection_cubit.dart';
import 'package:locally/presentation/auth/bloc/ages_display_cubit.dart';
import 'package:locally/presentation/auth/bloc/gender_selection_cubit.dart';
import 'package:locally/presentation/auth/bloc/obscure_password_cubit.dart';
import 'package:locally/presentation/auth/pages/gender_and_age_selection.dart';
import 'package:locally/presentation/auth/pages/signin.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _firstNameCon = TextEditingController();
  final TextEditingController _lastNameCon = TextEditingController();
  final TextEditingController _emailCon = TextEditingController();
  final TextEditingController _passwordCon = TextEditingController();

  String? _firstNameError;
  String? _lastNameError;
  String? _emailError;
  String? _passwordError;

  @override
  void dispose() {
    _firstNameCon.dispose();
    _lastNameCon.dispose();
    _emailCon.dispose();
    _passwordCon.dispose();
    super.dispose();
  }

  bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  bool isValidPassword(String password) {
    return RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[A-Za-z\d@$!%*?&]{8,}$')
        .hasMatch(password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (_) => ObscurePasswordCubit(),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 27, vertical: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _createAccountTitle(),
                const SizedBox(height: 24),
                _firstNameField(),
                const SizedBox(height: 16),
                _lastNameField(),
                const SizedBox(height: 16),
                _emailField(),
                const SizedBox(height: 16),
                _passwordField(),
                const SizedBox(height: 24),
                _continueButton(),
                const SizedBox(height: 16),
                _haveAccountText(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _createAccountTitle() {
    return const Text(
      'Create Account',
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: AppColors.text,
      ),
    );
  }

  Widget _firstNameField() {
    return TextField(
      cursorColor: AppColors.primary,
      controller: _firstNameCon,
      style: TextStyle(
        color: AppColors.text,
      ),
      decoration: InputDecoration(
        hintText: 'First Name',
        border: const OutlineInputBorder(),
        errorText: _firstNameError,
      ),
    );
  }

  Widget _lastNameField() {
    return TextField(
      controller: _lastNameCon,
      style: TextStyle(
        color: AppColors.text,
      ),
      decoration: InputDecoration(
        hintText: 'Last Name',
        border: const OutlineInputBorder(),
        errorText: _lastNameError,
      ),
    );
  }

  Widget _emailField() {
    return TextField(
      controller: _emailCon,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(
        color: AppColors.text,
      ),
      decoration: InputDecoration(
        hintText: 'Email Address',
        border: const OutlineInputBorder(),
        errorText: _emailError,
      ),
    );
  }

  Widget _passwordField() {
    return BlocBuilder<ObscurePasswordCubit, bool>(
      builder: (context, obscure) {
        return TextField(
          controller: _passwordCon,
          obscureText: obscure,
          style: TextStyle(
            color: AppColors.text,
          ),
          decoration: InputDecoration(
            hintText: 'Enter Password',
            border: const OutlineInputBorder(),
            errorText: _passwordError,
            suffixIcon: IconButton(
              icon: Icon(
                obscure ? Icons.visibility_off : Icons.visibility,
              ),
              onPressed: () {
                context.read<ObscurePasswordCubit>().toggle();
              },
            ),
          ),
        );
      },
    );
  }

  Widget _continueButton() {
    return BasicAppButton(
      onPressed: () {
        setState(() {
          _firstNameError = null;
          _lastNameError = null;
          _emailError = null;
          _passwordError = null;
        });

        final firstName = _firstNameCon.text.trim();
        final lastName = _lastNameCon.text.trim();
        final email = _emailCon.text.trim();
        final password = _passwordCon.text.trim();

        bool hasError = false;

        if (firstName.isEmpty) {
          _firstNameError = 'First name is required';
          hasError = true;
        }

        if (lastName.isEmpty) {
          _lastNameError = 'Last name is required';
          hasError = true;
        }

        if (email.isEmpty) {
          _emailError = 'Email is required';
          hasError = true;
        } else if (!isValidEmail(email)) {
          _emailError = 'Enter a valid email';
          hasError = true;
        }

        if (password.isEmpty) {
          _passwordError = 'Password is required';
          hasError = true;
        } else if (!isValidPassword(password)) {
          _passwordError =
          'Password must include:\n• 8+ characters\n• Upper/lower case\n• Number';
          hasError = true;
        }

        if (hasError) {
          setState(() {});
          return;
        }

        final userReq = UserCreationReq(
          firstName: firstName,
          lastName: lastName,
          email: email,
          password: password,
        );

        AppNavigator.push(
          context,
          MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => GenderSelectionCubit()),
              BlocProvider(create: (_) => AgeSelectionCubit()),
              BlocProvider(create: (_) => AgesDisplayCubit()),
              BlocProvider(create: (_) => ButtonStateCubit()),
              BlocProvider(create: (_) => ObscurePasswordCubit()),
            ],
            child: GenderAndAgeSelectionPage(userCreationReq: userReq),
          ),
        );
      },
      title: 'Continue',
    );
  }

  Widget _haveAccountText() {
    return RichText(
      text: TextSpan(
        style: const TextStyle(color: AppColors.text,),
        children: [
          const TextSpan(text: "Do you have an account? "),
          TextSpan(
            text: 'Sign in',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                AppNavigator.push(context, const SigninPage());
              },
          ),
        ],
      ),
    );
  }
}
