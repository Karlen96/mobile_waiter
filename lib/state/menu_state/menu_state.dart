import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:uuid/uuid.dart';

import '../../data_base/data_base_provider.dart';
import '../../models/category_model/category_model.dart';
import '../../models/order_model/order_model.dart';
import '../../models/product_model/product_model.dart';
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
  void onRemove(int productItemId) {
    final index = basket.indexWhere((e) => e.productId == productItemId);
    if (!index.isNegative) {
      basket.removeAt(index);
    }
  }

  void onSave() {
    ordersState.insertOrders(basket);
  }

  void onPay() {
    ordersState.finishOrders(basket);
  }

  @action
  void onAddProduct({
    required ProductModel product,
    required CategoryModel category,
    required int tableId,
  }) {
    var orderId = const Uuid().v4();

    // final onGoingOrders = ordersState.orders.where(
    final onGoingOrders = basket.where(
      (e) => e.tableId == tableId && e.isFinished == 0,
    );

    if (onGoingOrders.isNotEmpty) {
      orderId = onGoingOrders.first.id;
    }

    final order = OrderModel(
      id: orderId,
      productId: product.id,
      productName: product.name,
      productPrice: product.price,
      productCount: 1,
      categoryName: category.name,
      categoryId: category.id,
      isFinished: 0,
      tableId: tableId,
    );

    final index = basket.indexWhere(
      (e) => e.productId == product.id,
    );
    if (!index.isNegative) {
      onIncrementCount(
        productItemId: product.id,
        tableId: tableId,
      );
      return;
    }

    basket.add(order);
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
            (e) => e.tableId == tableId && e.isFinished == 0,
          )
          .toList()
          .asObservable();
    } catch (e) {
      ///
    }
  }

  @action
  void onIncrementCount({
    required int productItemId,
    required int tableId,
  }) {
    final index = basket.indexWhere(
      (e) => e.productId == productItemId && e.tableId == tableId,
    );
    if (!index.isNegative) {
      final count = basket[index].productCount;
      basket[index] = basket[index].copyWith(
        productCount: count + 1,
      );
    }
  }

  @action
  void onDecrementCount({
    required int productItemId,
    required int tableId,
  }) {
    final index = basket.indexWhere(
      (e) => e.productId == productItemId && e.tableId == tableId,
    );
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
