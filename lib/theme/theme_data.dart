import 'package:flutter/material.dart';

final theme = ThemeData(
  elevatedButtonTheme: const ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStatePropertyAll(
        Colors.blueAccent,
      ),
      foregroundColor: MaterialStatePropertyAll(
        Colors.white,
      ),
    ),
  ),
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
  useMaterial3: true,
);
