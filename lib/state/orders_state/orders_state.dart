import 'package:mobx/mobx.dart';
import 'package:waiter_app/models/order_model/order_model.dart';

part 'orders_state.g.dart';

class OrdersState = OrdersStateBase with _$OrdersState;

abstract class OrdersStateBase with Store {
  @observable
  ObservableList<OrderModel> orders = ObservableList<OrderModel>();

  @computed
  List<OrderModel> get finishedOrders {
    final _orders = <OrderModel>[];
    for (var i = 0; i < orders.length; i++) {
      if (!_orders.map((e) => e.id).contains(orders[i].id)) {
        _orders.add(orders[i]);
      }
    }

    return _orders;
  }

  hasActiveOrder(int tableId) {

  }

  bool isFreeTable(int tableId) {
    final res = orders.where(
          (e) => e.tableId == tableId && e.isFinished == 0,
    );

    return res.isEmpty;
  }
}
