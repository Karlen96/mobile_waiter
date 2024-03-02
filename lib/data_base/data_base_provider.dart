import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:sqflite/sqflite.dart';
import 'package:waiter_app/models/category_model/category_model.dart';

import '../configs/main_configs.dart';
import '../models/order_model/order_model.dart';
import '../models/product_model/product_model.dart';
import '../models/table_model/table_model.dart';
import '../state/orders_state/orders_state.dart';
import '../state/tables_state/tables_state.dart';
import 'migrations/initial_migration.dart';

class DataBaseProvider {
  static late final Database db;

  static Future<void> init() async {
    db = await openDatabase(
      dataBaseName,
      version: 1,
      onCreate: (Database db, int version) async {
        /// create migration if dataBase is not exists
        InitialMigration.initInitialTables(db);
      },
    );
  }

  static Future<void> getInitialData() async {
    /// Set tables data
    final tables = await db.rawQuery('SELECT * FROM ${TableNames.tables}');
    final tablesArray = List<TableModel>.from(
      tables.map(
        (model) => TableModel.fromJson(model),
      ),
    );
    GetIt.I<TablesState>().tables = tablesArray.asObservable();

    /// Set orders data
    final orders = await db.rawQuery('SELECT * FROM ${TableNames.orders}');
    final ordersArray = List<OrderModel>.from(
      orders.map(
        (model) => OrderModel.fromJson(model),
      ),
    );
    GetIt.I<OrdersState>().orders = ordersArray.asObservable();
  }

  static Future<List<CategoryModel>> getCategories() async {
    final categories = await db.rawQuery(
      'SELECT * FROM ${TableNames.categories}',
    );
    final categoriesArray = List<CategoryModel>.from(
      categories.map(
        (model) => CategoryModel.fromJson(model),
      ),
    );

    return categoriesArray;
  }

  static Future<List<ProductModel>> getProducts() async {
    final products = await db.rawQuery(
      'SELECT * FROM ${TableNames.products}',
    );
    final productsArray = List<ProductModel>.from(
      products.map(
        (model) => ProductModel.fromJson(model),
      ),
    );

    return productsArray;
  }
}
