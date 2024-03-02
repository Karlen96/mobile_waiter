import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../models/order_model/order_model.dart';
import '../../state/orders_state/orders_state.dart';

class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({
    super.key,
    required this.orderId,
  });

  final int orderId;

  OrdersState get ordersState => GetIt.I<OrdersState>();

  List<OrderModel> get list => ordersState.orders
      .where(
        (e) => e.id == orderId,
      )
      .toList();

  double get sum => list.fold(0, (p, e) => p + e.productPrice * e.productCount);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.shade50,
        title: Text('Order: ${list.first.id}'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Sum: ${sum.toStringAsFixed(1)}'),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (_, i) {
          return ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    '${list[i].productName}      count ${list[i].productCount}',
                  ),
                ),
                Text('price: ${list[i].productPrice}'),
              ],
            ),
            subtitle: Text(
              'Total: ${list[i].productCount * list[i].productPrice}',
            ),
          );
        },
      ),
    );
  }
}
