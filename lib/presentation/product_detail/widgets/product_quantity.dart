import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locally/core/configs/theme/app_colors.dart';
import 'package:locally/domain/product/entities/product.dart';
import 'package:locally/presentation/product_detail/bloc/product_quantity_cubit.dart';

class ProductQuantity extends StatelessWidget {
  final ProductEntity productEntity;

  const ProductQuantity({
    required this.productEntity,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.only(left: 12, right: 16),
      decoration: BoxDecoration(
        color: AppColors.secondBackground,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Quantity',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: AppColors.text,
            ),
          ),
          Row(
            children: [
              QuantityButton(
                onTap: () => context.read<ProductQuantityCubit>().decrement(),
                icon: Icons.remove,
              ),
              const SizedBox(width: 12),
              BlocBuilder<ProductQuantityCubit, int>(
                builder: (context, state) => Text(
                  state.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: AppColors.text,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              QuantityButton(
                onTap: () => context.read<ProductQuantityCubit>().increment(),
                icon: Icons.add,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class QuantityButton extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;

  const QuantityButton({required this.onTap, required this.icon, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        width: 40,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.primary,
        ),
        child: Center(
          child: Icon(icon, size: 24, color: Colors.white),
        ),
      ),
    );
  }
}
