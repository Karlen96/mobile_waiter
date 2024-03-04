import 'package:get_it/get_it.dart';

import 'orders_state/orders_state.dart';
import 'tables_state/tables_state.dart';

void registerSingletons() {
  GetIt.I.registerSingleton<OrdersState>(OrdersState());
  GetIt.I.registerSingleton<TablesState>(TablesState());
}
