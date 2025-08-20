import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:locally/common/helper/navigator/app_navigator.dart';
import 'package:locally/core/configs/assets/app_vectors.dart';
import 'package:locally/core/configs/theme/app_colors.dart';
import 'package:locally/presentation/auth/pages/signin.dart';
import 'package:locally/presentation/navigation/pages/main_navigation.dart';
import 'package:locally/presentation/splash/bloc/splash_cubit.dart';
import 'package:locally/presentation/splash/bloc/splash_state.dart';

class SplashPage extends StatelessWidget {
   const SplashPage({super.key});

   @override
   Widget build(BuildContext context) {
     return BlocListener<SplashCubit,SplashState>(
       listener: (context, state){
         if (state is UnAuthenticated)
         {
           AppNavigator.pushReplacementUntil(context, SigninPage());

         }
         if(state is Authenticated){
           AppNavigator.pushReplacementUntil(context, MainNavigation());
         }
       },
       child: Scaffold(
        backgroundColor: AppColors.primary,
         body: Center(
           child: SvgPicture.asset(
             AppVectors.appLogo,
             width: 200,
             height: 100,
             color: Colors.white,
           ),
         ),
       ),
     );
   }
 }
