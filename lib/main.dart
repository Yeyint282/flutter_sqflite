import 'package:flutter/material.dart';
import 'package:flutter_sqflite/database/expense_db.dart';
import 'package:flutter_sqflite/inherited_widget/database_provider.dart';

import 'package:flutter_sqflite/ui/screen/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ExpenseDatabaseHelper expenseDatabaseHelper = ExpenseDatabaseHelper();
  await expenseDatabaseHelper.init();
  runApp(
    MyApp(expenseDatabaseHelper: expenseDatabaseHelper),
  );
}

class MyApp extends StatelessWidget {
  final ExpenseDatabaseHelper expenseDatabaseHelper;
  const MyApp({super.key, required this.expenseDatabaseHelper});

  @override
  Widget build(BuildContext context) {
    return DatabaseProvider(
      expenseDatabaseHelper,
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark(),
          // home: Home(expenseDatabaseHelper: expenseDatabaseHelper),
          home: const MainScreen()),
    );
  }
}
