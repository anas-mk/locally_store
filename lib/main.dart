import 'package:firebase_core/firebase_core.dart';
import 'package:locally/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locally/core/configs/theme/app_theme.dart';
import 'package:locally/presentation/cart/bloc/cart_products_display_cubit.dart';
import 'package:locally/presentation/splash/bloc/splash_cubit.dart';
import 'package:locally/presentation/splash/pages/splash.dart';
import 'package:locally/service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SplashCubit()..appStarted()),
        BlocProvider(
          create: (_) => CartProductsDisplayCubit()..displayCartProducts(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.appTheme,
        home: const SplashPage(),
      ),
    );
  }
}
