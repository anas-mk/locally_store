import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locally/common/bloc/button/button_state.dart';
import 'package:locally/common/bloc/button/button_state_cubit.dart';
import 'package:locally/common/helper/product/product_price.dart';
import 'package:locally/core/configs/theme/app_colors.dart';
import 'package:locally/data/order/models/add_to_cart_req.dart';
import 'package:locally/domain/order/usecases/add_to_cart.dart';
import 'package:locally/domain/product/entities/product.dart';
import 'package:locally/presentation/cart/bloc/cart_products_display_cubit.dart';
import 'package:locally/presentation/product_detail/bloc/product_color_selection_cubit.dart';
import 'package:locally/presentation/product_detail/bloc/product_quantity_cubit.dart';
import 'package:locally/presentation/product_detail/bloc/product_size_selection_cubit.dart';

class AddToBag extends StatelessWidget {
  final ProductEntity productEntity;

  const AddToBag({required this.productEntity, super.key});

  void _handleAddToCart(BuildContext context) {
    final quantity = context.read<ProductQuantityCubit>().state;
    final colorIndex = context.read<ProductColorSelectionCubit>().selectedIndex;
    final sizeIndex = context.read<ProductSizeSelectionCubit>().selectedIndex;

    final selectedColor =
        (productEntity.colors.length > colorIndex)
            ? productEntity.colors[colorIndex].title
            : '';
    final selectedSize =
        (productEntity.sizes.length > sizeIndex)
            ? productEntity.sizes[sizeIndex]
            : '';

    final unitPrice = ProductPriceHelper.provideCurrentPrice(productEntity);
    final totalPrice = unitPrice * quantity;

    context.read<ButtonStateCubit>().execute(
      usecase: AddToCartUseCase(),
      params: AddToCartReq(
        productId: productEntity.productId,
        productTitle: productEntity.title,
        productQuantity: quantity,
        productColor: selectedColor,
        productSize: selectedSize,
        productPrice: productEntity.price.toDouble(),
        totalPrice: totalPrice,
        productImage:
            productEntity.images.isNotEmpty
                ? productEntity.images[0]
                : 'https://via.placeholder.com/150',
        createdDate: DateTime.now().toString(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ButtonStateCubit, ButtonState>(
      listener: (context, state) {
        if (state is ButtonSuccessState) {
          context.read<CartProductsDisplayCubit>().displayCartProducts();

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Added to bag successfully!',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              backgroundColor: Colors.green,
            ),
          );

          if (!context.mounted) return;
          context.read<ButtonStateCubit>().reset();
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 70,
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              onPressed:
                  state is ButtonLoadingState
                      ? null
                      : () => _handleAddToCart(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BlocBuilder<ProductQuantityCubit, int>(
                    builder: (context, quantity) {
                      final price =
                          ProductPriceHelper.provideCurrentPrice(
                            productEntity,
                          ) *
                          quantity;
                      return Text(
                        "\$${price.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      );
                    },
                  ),
                  state is ButtonLoadingState
                      ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                      : const Text(
                        'Add to Bag',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
