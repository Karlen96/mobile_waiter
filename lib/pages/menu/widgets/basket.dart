import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../state/menu_state/menu_state.dart';

class Basket extends StatelessWidget {
  const Basket({
    super.key,
    required this.menuState,
  });

  final MenuState menuState;

  String get title {
    var sum = 0.0;
    for (var i = 0; i < menuState.basket.length; i++) {
      sum +=
          menuState.basket[i].productCount * menuState.basket[i].productPrice;
    }

    return 'Sum: ${sum.toStringAsFixed(1)}';
  }

  void _onSave(BuildContext context) {
    menuState.onSave();
    Navigator.of(context).pop(true);
  }

  void _onPay(BuildContext context) {
    menuState.onPay();
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.only(
            top: 24,
            left: 24,
            right: 24,
            bottom: kBottomNavigationBarHeight * 2,
          ),
          child: Observer(
            builder: (_) {
              return Column(
                children: menuState.basket
                    .map(
                      (e) => Dismissible(
                        key: ValueKey(e.productId),
                        background: const ColoredBox(
                          color: Colors.red,
                        ),
                        onDismissed: (_) => menuState.onRemove(e.productId),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                '${e.productName} : ${e.productPrice}',
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () => menuState.onDecrementCount(
                                    productItemId: e.productId,
                                    tableId: e.tableId,
                                  ),
                                  icon: const Icon(Icons.remove),
                                ),
                                Text('${e.productCount}'),
                                IconButton(
                                  onPressed: () => menuState.onIncrementCount(
                                    productItemId: e.productId,
                                    tableId: e.tableId,
                                  ),
                                  icon: const Icon(Icons.add),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              );
            },
          ),
        ),
        Positioned(
          bottom: 24,
          left: 12,
          right: 12,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Observer(builder: (_) => Text(title)),
              const SizedBox(height: 8),
              Row(
                children: [
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _onSave(context),
                      child: const Text('Save'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _onPay(context),
                      child: const Text('Pay'),
                    ),
                  ),
                  const SizedBox(width: 12),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
