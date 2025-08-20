import 'package:flutter/material.dart';
import 'package:locally/common/helper/navigator/app_navigator.dart';
import 'package:locally/common/widgets/button/basic_app_button.dart';
import 'package:locally/core/configs/assets/app_images.dart';
import 'package:locally/core/configs/theme/app_colors.dart';
import 'package:locally/presentation/navigation/pages/main_navigation.dart';

class OrderPlacedPage extends StatelessWidget {
  const OrderPlacedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Image.asset(AppImages.orderPlaced),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
              decoration: const BoxDecoration(
                color: AppColors.secondBackground,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Order Placed Successfully',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: AppColors.text,
                    ),
                  ),
                  const SizedBox(height: 30),
                  BasicAppButton(
                    title: 'Finish',
                    onPressed: () {
                      AppNavigator.pushAndRemove(context, MainNavigation());
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
