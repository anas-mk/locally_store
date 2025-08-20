import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locally/common/bloc/button/button_state.dart';
import 'package:locally/common/bloc/button/button_state_cubit.dart';
import 'package:locally/common/helper/navigator/app_navigator.dart';
import 'package:locally/common/widgets/appbar/app_bar.dart';
import 'package:locally/common/widgets/button/basic_reactive_button.dart';
import 'package:locally/domain/auth/usecases/send_password_reset_email.dart';
import 'package:locally/presentation/auth/pages/password_reset_email.dart';

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({super.key});

  final TextEditingController _emailCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbar(),
      body: BlocProvider(
        create: (context) => ButtonStateCubit(),
        child: BlocListener<ButtonStateCubit, ButtonState>(
          listener: (context, state) {
            if (state is ButtonFailureState) {
              var snackbar = SnackBar(content: Text(state.errorMessage), behavior: SnackBarBehavior.floating,);
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
            }
            if(state is ButtonSuccessState)
            {
              AppNavigator.push(
                context,
                PasswordResetEmailPage(),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 27,
              vertical: 15,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _forgetPasswordText(context),
                const SizedBox(height: 16,),
                _emailAddressField(context),
                const SizedBox(height: 16,),
                _continueButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget _forgetPasswordText(BuildContext context) {
    return const Text(
      'Forget Password',
      style: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold
      ),
    );
  }

  Widget _emailAddressField(BuildContext context) {
    return TextField(
      controller: _emailCon,
      decoration: const InputDecoration(
        hintText: 'Enter Email address',
      ),
    );
  }

  Widget _continueButton(BuildContext context) {
    return Builder(
      builder: (context) {
        return BasicReactiveButton(
          onPressed: (){
            context.read<ButtonStateCubit>().execute(
              usecase: SendPasswordResetEmailUseCase(),
              params: _emailCon.text,
            );
          },
          title: 'Continue',
      );
      }
    );
  }

}

