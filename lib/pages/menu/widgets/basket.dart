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

    return sum.toStringAsFixed(1);
  }

  Future<void> _onSave(BuildContext context) async {
    await menuState.onSave();
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
                        onDismissed: (_) => menuState.onRemove(e.id),
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
                                  onPressed: () =>
                                      menuState.onDecrementCount(e.id),
                                  icon: const Icon(Icons.remove),
                                ),
                                Text('${e.productCount}'),
                                IconButton(
                                  onPressed: () =>
                                      menuState.onIncrementCount(e.id),
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
          child: ElevatedButton(
            onPressed: () => _onSave(context),
            child: Observer(builder: (_) {
              return Text(title);
            }),
          ),
        ),
      ],
    );
  }
}
