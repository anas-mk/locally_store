import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:locally/common/helper/navigator/app_navigator.dart';
import 'package:locally/common/widgets/button/basic_app_button.dart';
import 'package:locally/presentation/auth/pages/signin.dart';

class SignOut extends StatelessWidget {
  const SignOut({super.key});

  @override
  Widget build(BuildContext context) {
    return BasicAppButton(
      onPressed: () async {
        await FirebaseAuth.instance.signOut();
        AppNavigator.pushReplacementUntil(context, SigninPage());

      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        elevation: 0,
        shadowColor: Colors.transparent,
      ),
      content: Text(
        'Sign Out',
        style: TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.w400,
          fontSize: 20,
        ),
      ),
    );
  }
}
