import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
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
                itemBuilder: (_, int i) {
                  return InkWell(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => MenuPage(
                          table: tablesState.tables[i],
                        ),
                      ),
                    ),
                    child: ColoredBox(
                      color: ordersState.isFreeTable(tablesState.tables[i].id)
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
                    ),
                  );
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
