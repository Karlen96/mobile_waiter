// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MenuState on MenuStateBase, Store {
  late final _$categoriesAtom =
      Atom(name: 'MenuStateBase.categories', context: context);

  @override
  ObservableList<CategoryModel> get categories {
    _$categoriesAtom.reportRead();
    return super.categories;
  }

  @override
  set categories(ObservableList<CategoryModel> value) {
    _$categoriesAtom.reportWrite(value, super.categories, () {
      super.categories = value;
    });
  }

  late final _$basketAtom =
      Atom(name: 'MenuStateBase.basket', context: context);

  @override
  ObservableList<OrderModel> get basket {
    _$basketAtom.reportRead();
    return super.basket;
  }

  @override
  set basket(ObservableList<OrderModel> value) {
    _$basketAtom.reportWrite(value, super.basket, () {
      super.basket = value;
    });
  }

  late final _$initStateAsyncAction =
      AsyncAction('MenuStateBase.initState', context: context);

  @override
  Future<void> initState(int tableId) {
    return _$initStateAsyncAction.run(() => super.initState(tableId));
  }

  late final _$MenuStateBaseActionController =
      ActionController(name: 'MenuStateBase', context: context);

  @override
  void onRemove(int productItemId) {
    final _$actionInfo = _$MenuStateBaseActionController.startAction(
        name: 'MenuStateBase.onRemove');
    try {
      return super.onRemove(productItemId);
    } finally {
      _$MenuStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onAddProduct(
      {required ProductModel product,
      required CategoryModel category,
      required int tableId}) {
    final _$actionInfo = _$MenuStateBaseActionController.startAction(
        name: 'MenuStateBase.onAddProduct');
    try {
      return super
          .onAddProduct(product: product, category: category, tableId: tableId);
    } finally {
      _$MenuStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onIncrementCount({required int productItemId, required int tableId}) {
    final _$actionInfo = _$MenuStateBaseActionController.startAction(
        name: 'MenuStateBase.onIncrementCount');
    try {
      return super
          .onIncrementCount(productItemId: productItemId, tableId: tableId);
    } finally {
      _$MenuStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onDecrementCount({required int productItemId, required int tableId}) {
    final _$actionInfo = _$MenuStateBaseActionController.startAction(
        name: 'MenuStateBase.onDecrementCount');
    try {
      return super
          .onDecrementCount(productItemId: productItemId, tableId: tableId);
    } finally {
      _$MenuStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
categories: ${categories},
basket: ${basket}
    ''';
  }
}
