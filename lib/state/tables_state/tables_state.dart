import 'package:mobx/mobx.dart';
import '../../models/table_model/table_model.dart';

part 'tables_state.g.dart';

class TablesState = TablesStateBase with _$TablesState;

abstract class TablesStateBase with Store {
  @observable
  ObservableList<TableModel> tables = ObservableList<TableModel>();
}
