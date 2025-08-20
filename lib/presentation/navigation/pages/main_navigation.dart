import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:locally/core/configs/assets/app_vectors.dart';
import 'package:locally/core/configs/theme/app_colors.dart';
import 'package:locally/presentation/all_categories/pages/all_categories.dart';
import 'package:locally/presentation/cart/pages/cart.dart';
import 'package:locally/presentation/home/pages/home.dart';
import 'package:locally/presentation/navigation/bloc/navigation_cubit.dart';
import 'package:locally/presentation/settings/pages/settings.dart';

class MainNavigation extends StatelessWidget {
  const MainNavigation({super.key});

  List<Widget> get _screens => const [
    HomePage(),
    AllCategoriesPage(),
    CartPage(),
    SettingsPage(),
  ];

  BottomNavigationBarItem _buildSvgNavItem(
      String asset, String label, bool isSelected) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        asset,
        height: 24,
        width: 24,
        color: isSelected ? AppColors.primary : Colors.grey,
      ),
      label: label,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NavigationCubit(),
      child: BlocBuilder<NavigationCubit, int>(
        builder: (context, currentIndex) {
          return Scaffold(
            body: SafeArea(
              child: IndexedStack(
                index: currentIndex,
                children: _screens,
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: currentIndex,
              backgroundColor: AppColors.secondBackground,
              selectedItemColor: AppColors.primary,
              unselectedItemColor: Colors.grey,
              onTap: (index) =>
                  context.read<NavigationCubit>().changeTab(index),
              items: [
                _buildSvgNavItem(AppVectors.home, "Home", currentIndex == 0),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.category_outlined),
                  label: "Categories",
                ),
                _buildSvgNavItem(AppVectors.bag, "Cart", currentIndex == 2),
                _buildSvgNavItem(AppVectors.profile, "Profile", currentIndex == 3),
              ],
            ),
          );
        },
      ),
    );
  }
}
