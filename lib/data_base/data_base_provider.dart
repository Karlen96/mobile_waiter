import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:sqflite/sqflite.dart';

import '../configs/main_configs.dart';
import '../models/category_model/category_model.dart';
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
      onCreate: (db, version) {
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
    final orders = await getOrders();
    GetIt.I<OrdersState>().orders = orders.asObservable();
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

  static Future<List<OrderModel>> getOrders() async {
    final orders = await db.rawQuery(
      'SELECT * FROM ${TableNames.orders}',
    );
    final ordersArray = List<OrderModel>.from(
      orders.map(
        (model) => OrderModel.fromJson(model),
      ),
    );

    return ordersArray;
  }

  static Future<void> insertOrders() async {
    await db.execute('DELETE FROM ${TableNames.orders}');

    final orders = GetIt.I<OrdersState>().orders;

    for (var i = 0; i < orders.length; i++) {
      db.execute(
        'INSERT INTO ${TableNames.orders} (id, table_id, product_id, product_name, product_price, product_count, category_name, category_id, isFinished) VALUES("${orders[i].id}", ${orders[i].tableId}, ${orders[i].productId}, "${orders[i].productName}", ${orders[i].productPrice}, ${orders[i].productCount}, "${orders[i].categoryName}", ${orders[i].categoryId}, ${orders[i].isFinished});',
      );
    }
  }
}
