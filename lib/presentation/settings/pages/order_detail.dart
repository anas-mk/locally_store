import 'package:flutter/material.dart';
import 'package:locally/common/helper/navigator/app_navigator.dart';
import 'package:locally/common/widgets/appbar/app_bar.dart';
import 'package:locally/domain/order/entities/order.dart';
import 'package:locally/presentation/settings/pages/order_items.dart';
import '../../../core/configs/theme/app_colors.dart';

class OrderDetailPage extends StatelessWidget {
  final OrderEntity orderEntity;
  const OrderDetailPage({
    required this.orderEntity,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbar(
        title: Text('Order #${orderEntity.code}'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OrderStatusList(orderEntity: orderEntity),
            const SizedBox(height: 40),
            OrderItemsSection(orderEntity: orderEntity),
            const SizedBox(height: 30),
            ShippingSection(address: orderEntity.shippingAddress),
          ],
        ),
      ),
    );
  }
}

class OrderStatusList extends StatelessWidget {
  final OrderEntity orderEntity;
  const OrderStatusList({super.key, required this.orderEntity});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: orderEntity.orderStatus.length,
      reverse: true,
      separatorBuilder: (_, __) => const SizedBox(height: 40),
      itemBuilder: (context, index) {
        final status = orderEntity.orderStatus[index];
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 15,
                  backgroundColor:
                  status.done ? AppColors.primary : Colors.white,
                  child: status.done
                      ? const Icon(Icons.check, size: 18, color: Colors.white)
                      : null,
                ),
                const SizedBox(width: 12),
                Text(
                  status.title,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: status.done ? AppColors.text : Colors.grey,
                  ),
                ),
              ],
            ),
            Text(
              status.createdDate.toDate().toString().split(' ')[0],
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: status.done ? AppColors.text : Colors.grey,
              ),
            ),
          ],
        );
      },
    );
  }
}

class OrderItemsSection extends StatelessWidget {
  final OrderEntity orderEntity;
  const OrderItemsSection({super.key, required this.orderEntity});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Order Items',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.text),
        ),
        const SizedBox(height: 12),
        InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () => AppNavigator.push(
            context,
            OrderItemsPage(products: orderEntity.products),
          ),
          child: Container(
            height: 70,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: AppColors.secondBackground,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.receipt_rounded, color: AppColors.text),
                    const SizedBox(width: 16),
                    Text(
                      '${orderEntity.products.length} Items',
                      style: const TextStyle(
                        fontSize: 16,
                        color: AppColors.text,
                      ),
                    ),
                  ],
                ),
                const Text(
                  'View All',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ShippingSection extends StatelessWidget {
  final String address;
  const ShippingSection({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Shipping details',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: AppColors.text,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.secondBackground,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            address,
            style: const TextStyle(fontSize: 16, color: AppColors.text),
          ),
        ),
      ],
    );
  }
}
