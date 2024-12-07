import 'package:flutter/material.dart';
import 'package:flutter_sqflite/database/model/expense_model.dart';
import 'package:flutter_sqflite/inherited_widget/database_provider.dart';
import 'package:flutter_sqflite/ui/screen/save_screen.dart';
import 'package:flutter_sqflite/utils/date_time_utils.dart';

import '../widget/expense_list_detail_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<ExpenseModel>> _todayExpenseFuture;
  late Future<Map<String, dynamic>> _todayCostFuture;
  late DatabaseProvider databaseProvider;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    databaseProvider = DatabaseProvider.of(context);
    _todayExpenseFuture =
        databaseProvider.expenseDatabaseHelper.getAllExpenseByDate(todayDate());
    _todayCostFuture =
        databaseProvider.expenseDatabaseHelper.totalCostOfDay(todayDate());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.lime,
        title: Text(
          'Daily Expense(Today ${todayDate()})',
          style: const TextStyle(color: Colors.black),
        ),
        leading: const FlutterLogo(),
      ),
      body: ExpenseListDetailWidget(
        todayCostFuture: _todayCostFuture,
        todayExpenseFuture: _todayExpenseFuture,
        delete: (int position) async {
          await databaseProvider.expenseDatabaseHelper
              .deleteExpenseById(position);
          _refreshScreen();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String? dialogResult = await showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Enter your expense'),
                  content: SaveScreen(
                    expenseDatabaseHelper:
                        databaseProvider.expenseDatabaseHelper,
                  ),
                );
              });
          if (dialogResult == 'inserted') {
            _refreshScreen();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _refreshScreen() {
    setState(() {
      _todayCostFuture =
          databaseProvider.expenseDatabaseHelper.totalCostOfDay(todayDate());
      _todayExpenseFuture = databaseProvider.expenseDatabaseHelper
          .getAllExpenseByDate(todayDate());
    });
  }
}
