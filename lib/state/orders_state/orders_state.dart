import 'package:mobx/mobx.dart';
import '../../models/order_model/order_model.dart';

part 'orders_state.g.dart';

class OrdersState = OrdersStateBase with _$OrdersState;

abstract class OrdersStateBase with Store {
  @observable
  ObservableList<OrderModel> orders = ObservableList<OrderModel>();

  @computed
  List<OrderModel> get finishedOrders {
    final _orders = <OrderModel>[];
    for (var i = 0; i < orders.length; i++) {
      if (!_orders.map((e) => e.id).contains(orders[i].id) &&
          orders[i].isFinished == 1) {
        _orders.add(orders[i]);
      }
    }

    return _orders;
  }

  @action
  void insertOrders(List<OrderModel> items) {
    for (var i = 0; i < items.length; i++) {
      final index = orders.indexWhere(
        (e) =>
            e.productId == items[i].productId &&
            e.tableId == items[i].tableId &&
            e.id == items[i].id,
      );
      if (!index.isNegative) {
        orders[index] = items[i];
      } else {
        orders.add(items[i]);
      }
    }

    /// update database
    updateDatabase();
  }

  @action
  void finishOrders(List<OrderModel> items) {
    for (var i = 0; i < items.length; i++) {
      final index = orders.indexWhere(
        (e) =>
            e.productId == items[i].productId &&
            e.tableId == items[i].tableId &&
            e.id == items[i].id,
      );
      if (!index.isNegative) {
        orders[index] = orders[index].copyWith(
          productCount: items[i].productCount,
          isFinished: 1,
        );
      } else {
        orders.add(
          items[i].copyWith(
            isFinished: 1,
          ),
        );
      }
    }

    /// update database
    updateDatabase();
  }

  Future<void> updateDatabase() async {}
}
