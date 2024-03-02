// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orders_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$OrdersState on OrdersStateBase, Store {
  Computed<List<OrderModel>>? _$finishedOrdersComputed;

  @override
  List<OrderModel> get finishedOrders => (_$finishedOrdersComputed ??=
          Computed<List<OrderModel>>(() => super.finishedOrders,
              name: 'OrdersStateBase.finishedOrders'))
      .value;

  late final _$ordersAtom =
      Atom(name: 'OrdersStateBase.orders', context: context);

  @override
  ObservableList<OrderModel> get orders {
    _$ordersAtom.reportRead();
    return super.orders;
  }

  @override
  set orders(ObservableList<OrderModel> value) {
    _$ordersAtom.reportWrite(value, super.orders, () {
      super.orders = value;
    });
  }

  @override
  String toString() {
    return '''
orders: ${orders},
finishedOrders: ${finishedOrders}
    ''';
  }
}
