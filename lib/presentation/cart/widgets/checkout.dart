
import 'package:flutter/material.dart';
import 'package:locally/common/helper/cart/cart.dart';
import 'package:locally/common/helper/navigator/app_navigator.dart';
import 'package:locally/common/widgets/button/basic_app_button.dart';
import 'package:locally/core/configs/theme/app_colors.dart';
import 'package:locally/domain/order/entities/product_ordered.dart';
import 'package:locally/presentation/cart/pages/checkout.dart';

class Checkout extends StatelessWidget {
  final List<ProductOrderedEntity> products;
  const Checkout({
    required this.products,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: MediaQuery.of(context).size.height / 3.5,
      color: AppColors.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Subtotal',
                style: TextStyle(
                    color: Colors.grey,
                  fontSize: 16
                ),
              ),
              Text(
                '\$${CartHelper.calculateCartSubtotal(products).toString()}',
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.text,
                ),
              )
            ],
          ),
             const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Shipping Cost',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              Text(
                '\$8',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.text,
                ),
              )
            ],
          ),
             const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tax',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              Text(
                '\$0.0',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.text,
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,

                ),
              ),
              Text(
                '\$${CartHelper.calculateCartSubtotal(products) + 8 }',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: AppColors.text,
                ),
              )
            ],
          ),
          BasicAppButton(
            onPressed: (){
              AppNavigator.push(context, CheckOutPage(products: products,));
            },
            title: 'Checkout',

          )
        ],
      ),
    );
  }
}