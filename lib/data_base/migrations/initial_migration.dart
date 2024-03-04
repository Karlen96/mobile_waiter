import 'package:sqflite/sqflite.dart';

import '../../configs/main_configs.dart';

class InitialMigration {
  static Future<void> initInitialTables(Database db) async {
    /// create tables
    db
      ..execute(
        'CREATE TABLE ${TableNames.tables} (id INTEGER PRIMARY KEY, name TEXT, position INTEGER, size INTEGER);',
      )
      ..execute(
        'CREATE TABLE ${TableNames.categories} (id INTEGER PRIMARY KEY, name TEXT, position INTEGER);',
      )
      ..execute(
        'CREATE TABLE ${TableNames.products} (id INTEGER PRIMARY KEY, name TEXT, description TEXT, position INTEGER, category_id INTEGER, price DOUBLE);',
      )
      ..execute(
        'CREATE TABLE ${TableNames.orders} (id TEXT, table_id INTEGER, product_id INTEGER, product_name TEXT, product_price DOUBLE, product_count INTEGER, category_name TEXT, category_id INTEGER, isFinished BOOLEAN);',
      );

    /// insert tables
    for (var i = 0; i < 3; i++) {
      db.execute(
        'INSERT INTO ${TableNames.tables} (name, position, size) VALUES("Table $i", $i, ${(i + 1) * 2});',
      );
    }

    /// insert categories
    for (var i = 0; i < 2; i++) {
      db.execute(
        'INSERT INTO ${TableNames.categories} (name, position) VALUES("Category $i", $i);',
      );
    }

    /// insert product
    for (var i = 0; i < 3; i++) {
      db
        ..execute(
          'INSERT INTO ${TableNames.products} (name, description, category_id, price, position) VALUES("product $i", "description $i", 1, ${100 * (i + 1)}, $i);',
        )
        ..execute(
          'INSERT INTO ${TableNames.products} (name, description, category_id, price, position) VALUES("product $i", "description $i", 2, ${100 * (i + 1)}, $i);',
        );
    }
  }
}
