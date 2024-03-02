import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../../state/orders_state/orders_state.dart';
import '../order_details/order_details_page.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  OrdersState get ordersState => GetIt.I<OrdersState>();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        Observer(builder: (context) {
          final orders = ordersState.finishedOrders;

          if (orders.isEmpty) {
            return const SliverFillRemaining(
              child: Center(
                child: Text('Empty orders'),
              ),
            );
          }

          return SliverList.builder(
            itemCount: orders.length,
            itemBuilder: (_, int i) {
              return ListTile(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => OrderDetailsPage(
                      orderId: orders[i].id,
                    ),
                  ),
                ),
                title: Text('Order ${orders[i].id}'),
              );
            },
          );
        }),
      ],
    );
  }
}
