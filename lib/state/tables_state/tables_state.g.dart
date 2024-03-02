// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tables_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TablesState on TablesStateBase, Store {
  late final _$tablesAtom =
      Atom(name: 'TablesStateBase.tables', context: context);

  @override
  ObservableList<TableModel> get tables {
    _$tablesAtom.reportRead();
    return super.tables;
  }

  @override
  set tables(ObservableList<TableModel> value) {
    _$tablesAtom.reportWrite(value, super.tables, () {
      super.tables = value;
    });
  }

  @override
  String toString() {
    return '''
tables: ${tables}
    ''';
  }
}
