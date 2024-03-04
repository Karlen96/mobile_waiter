import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../../state/orders_state/orders_state.dart';
import '../../state/tables_state/tables_state.dart';
import '../menu/menu_page.dart';

class TablesPage extends StatelessWidget {
  const TablesPage({
    super.key,
  });

  TablesState get tablesState => GetIt.I<TablesState>();

  OrdersState get ordersState => GetIt.I<OrdersState>();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(12),
          sliver: Observer(
            builder: (_) {
              return SliverGrid.builder(
                itemCount: tablesState.tables.length,
                itemBuilder: (_, i) {
                  return InkWell(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => MenuPage(
                          table: tablesState.tables[i],
                        ),
                      ),
                    ),
                    child: Observer(
                      builder: (_) {
                        return ColoredBox(
                          color: ordersState.orders
                                  .where(
                                    (e) =>
                                        e.tableId == tablesState.tables[i].id &&
                                        e.isFinished == 0,
                                  )
                                  .isEmpty
                              ? Colors.blue
                              : Colors.red,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(tablesState.tables[i].name),
                                const SizedBox(height: 12),
                                Text('Size: ${tablesState.tables[i].size}'),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
