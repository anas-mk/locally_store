import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:locally/common/bloc/product/products_display_cubit.dart';
import 'package:locally/core/configs/assets/app_vectors.dart';
import 'package:locally/core/configs/theme/app_colors.dart';

class SearchField extends StatefulWidget {
  const SearchField({super.key});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final TextEditingController _controller = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _controller.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      if (value.isEmpty) {
        context.read<ProductsDisplayCubit>().displayInitial();
      } else {
        context.read<ProductsDisplayCubit>().displayProducts(params: value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(50),
      borderSide: BorderSide.none,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextField(
        controller: _controller,
        onChanged: _onSearchChanged,
        style: const TextStyle(color: AppColors.text),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(12),
          focusedBorder: border,
          enabledBorder: border,
          prefixIcon: SvgPicture.asset(
            AppVectors.search,
            fit: BoxFit.none,
            color: AppColors.text,
          ),
          hintText: 'Search',
          fillColor: AppColors.secondBackground,
        ),
      ),
    );
  }
}
