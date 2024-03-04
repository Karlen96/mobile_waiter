import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../../models/table_model/table_model.dart';
import '../../state/menu_state/menu_state.dart';
import '../../state/orders_state/orders_state.dart';
import 'widgets/basket.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({
    super.key,
    required this.table,
  });

  final TableModel table;

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final _menuState = MenuState();

  OrdersState get ordersState => GetIt.I<OrdersState>();

  Future<void> onPressed() async {
    final res = await showModalBottomSheet<bool?>(
      context: context,
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height * 0.4,
        maxHeight: MediaQuery.of(context).size.height * 0.7,
      ),
      builder: (_) => Basket(
        menuState: _menuState,
      ),
    );

    if (res == true) {
      Navigator.of(context).pop();
    }
  }

  @override
  void initState() {
    super.initState();
    _menuState.initState(widget.table.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.shade50,
        title: Text(widget.table.name),
      ),
      body: Observer(
        builder: (_) {
          return ListView.builder(
            itemCount: _menuState.categories.length,
            itemBuilder: (_, i) {
              return ExpansionTile(
                title: Text(_menuState.categories[i].name),
                children: _menuState.categories[i].products
                    .map(
                      (e) => ListTile(
                        onTap: () => _menuState.onAddProduct(
                          product: e,
                          category: _menuState.categories[i],
                          tableId: widget.table.id,
                        ),
                        title: Text('${e.name} : ${e.price}'),
                      ),
                    )
                    .toList(),
              );
            },
          );
        },
      ),
      floatingActionButton: Observer(
        builder: (_) {
          return FloatingActionButton(
            onPressed: _menuState.basket.isEmpty ? null : onPressed,
            child: const Text('Basket'),
          );
        },
      ),
    );
  }
}
