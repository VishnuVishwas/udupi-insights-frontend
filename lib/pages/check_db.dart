// lib/check_db.dart
// check if db tables created

import 'package:flutter/material.dart';

import '../database/database_helper.dart';


class CheckDb extends StatelessWidget {
  const CheckDb({super.key});

  Future<void> checkTables() async {
    final tables = await DatabaseHelper.instance.getTableNames();
    print('Tables in database: $tables');
  }

  void printDatabasePath() async {
    final path = await DatabaseHelper.instance.getDatabasePath();
    print('The Database Path: $path');
  }

  @override
  Widget build(BuildContext context) {
    // Call checkTables when this widget is built
    printDatabasePath();
    checkTables();


    return Scaffold(
      appBar: AppBar(title: const Text('Database Tables')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Checking database tables...'),
            // You can add more widgets here to show results or status
          ],
        ),
      ),
    );
  }
}
