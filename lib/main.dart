import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'configs/main_configs.dart';
import 'data_base/data_base_provider.dart';
import 'pages/dashboard/dashboard_page.dart';
import 'state/store_config.dart';
import 'theme/theme_data.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await deleteDatabase(dataBaseName);
    await DataBaseProvider.init();
    DataBaseProvider.getInitialData();
    registerSingletons();
  } catch (e) {
    deleteDatabase(dataBaseName);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Waiter App Demo',
      theme: theme,
      home: const DashboardPage(),
    );
  }
}
