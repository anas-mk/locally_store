import 'package:flutter/material.dart';
import 'package:locally/core/configs/theme/app_colors.dart';

class AppBottomSheet {

  static Future<void> display(BuildContext context,Widget widget) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(25),
          topLeft: Radius.circular(25)
        )
      ),
      builder: (_) {
        return widget;
      }
    );
  }
}