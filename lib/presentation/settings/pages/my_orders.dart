import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locally/common/helper/navigator/app_navigator.dart';
import 'package:locally/common/widgets/appbar/app_bar.dart';
import 'package:locally/core/configs/theme/app_colors.dart';
import 'package:locally/domain/order/entities/order.dart';
import 'package:locally/presentation/settings/bloc/orders_display_cubit.dart';
import 'package:locally/presentation/settings/bloc/orders_display_state.dart';
import 'package:locally/presentation/settings/pages/order_detail.dart';

class MyOrdersPage extends StatelessWidget {
  const MyOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppbar(title: Text('My Orders')),
      body: BlocProvider(
        create: (context) => OrdersDisplayCubit()..displayOrders(),
        child: const OrdersBody(),
      ),
    );
  }
}

class OrdersBody extends StatelessWidget {
  const OrdersBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersDisplayCubit, OrdersDisplayState>(
      builder: (context, state) {
        if (state is OrdersLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is OrdersLoaded) {
          final orders = state.orders.cast<OrderEntity>();
          if (orders.isEmpty) {
            return const Center(
              child: Text(
                "No orders yet",
                style: TextStyle(color: Colors.grey),
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: () async {
              context.read<OrdersDisplayCubit>().displayOrders();
            },
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: orders.length,
              separatorBuilder: (context, _) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final order = orders[index];
                return ListTile(
                  onTap: () => AppNavigator.push(
                    context,
                    OrderDetailPage(orderEntity: order),
                  ),
                  tileColor: AppColors.secondBackground,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  leading: const Icon(
                    Icons.receipt_rounded,
                    color: AppColors.text,
                  ),
                  title: Text(
                    "Order #${order.code}",
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: AppColors.text,
                    ),
                  ),
                  subtitle: Text(
                    "${order.products.length} item${order.products.length > 1 ? 's' : ''}",
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16,
                    color: AppColors.text,
                  ),
                );
              },
            ),
          );
        } else if (state is LoadOrdersFailure) {
          return Center(child: Text(state.errorMessage));
        }
        return const SizedBox.shrink();
      },
    );
  }
}
