import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import '../../data_base/data_base_provider.dart';
import '../../models/category_model/category_model.dart';
import '../../models/order_model/order_model.dart';
import '../orders_state/orders_state.dart';

part 'menu_state.g.dart';

class MenuState = MenuStateBase with _$MenuState;

abstract class MenuStateBase with Store {
  OrdersState get ordersState => GetIt.I<OrdersState>();

  @observable
  ObservableList<CategoryModel> categories = ObservableList<CategoryModel>();

  @observable
  ObservableList<OrderModel> basket = ObservableList<OrderModel>();

  @action
  void onRemove(int orderItemId) {
    final index = basket.indexWhere((e) => e.id == orderItemId);
    if (!index.isNegative) {
      basket.removeAt(index);
    }
  }

  Future<void> onSave() async {
    // ordersState.
    // final
  }

  @action
  void onAddProduct(OrderModel orderItem) {
    final index = basket.indexWhere(
      (e) => e.productId == orderItem.productId,
    );
    if (!index.isNegative) {
      onIncrementCount(orderItem.productId);
      return;
    }

    basket.add(orderItem);
  }

  @action
  Future<void> initState(int tableId) async {
    try {
      final _categories = await DataBaseProvider.getCategories();
      final _products = await DataBaseProvider.getProducts();

      // categories
      for (var i = 0; i < _categories.length; i++) {
        _categories[i] = _categories[i].copyWith(
          products: _products
              .where(
                (e) => e.categoryId == _categories[i].id,
              )
              .toList(),
        );
      }
      categories = _categories.asObservable();

      /// get initial basket
      basket = ordersState.orders
          .where(
            (e) => e.tableId == tableId,
          )
          .toList()
          .asObservable();
    } catch (e) {
      ///
    }
  }

  @action
  void onIncrementCount(int orderItemId) {
    final index = basket.indexWhere((e) => e.id == orderItemId);
    if (!index.isNegative) {
      final count = basket[index].productCount;
      basket[index] = basket[index].copyWith(
        productCount: count + 1,
      );
    }
  }

  @action
  void onDecrementCount(int orderItemId) {
    final index = basket.indexWhere((e) => e.id == orderItemId);
    if (!index.isNegative) {
      final count = basket[index].productCount;
      if (count == 0) {
        return;
      }
      basket[index] = basket[index].copyWith(
        productCount: count - 1,
      );
    }
  }
}
