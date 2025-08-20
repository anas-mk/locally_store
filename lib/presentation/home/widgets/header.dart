import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:locally/common/helper/navigator/app_navigator.dart';
import 'package:locally/core/configs/assets/app_vectors.dart';
import 'package:locally/core/configs/theme/app_colors.dart';
import 'package:locally/presentation/search/pages/search.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Expanded(child: SearchField()),
          SizedBox(width: 10),
          NotificationButton(),
        ],
      ),
    );
  }
}

class NotificationButton extends StatelessWidget {
  const NotificationButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
      },
      child: Container(
        height: 40,
        width: 40,
        decoration: const BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          AppVectors.notification,
          fit: BoxFit.none,
          color: Colors.white,
        ),
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: true,
      onTap: () => AppNavigator.push(context, const SearchPage()),
      decoration: InputDecoration(
        fillColor: const Color(0xfff6f6f6),
        filled: true,
        contentPadding: const EdgeInsets.all(12),
        hintText: 'Search',
        hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12),
          child: SvgPicture.asset(
            AppVectors.search,
            color: AppColors.text,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
