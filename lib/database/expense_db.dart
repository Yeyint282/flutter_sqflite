import 'package:flutter_sqflite/database/model/expense_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ExpenseDatabaseHelper {
  late Database _expenseDb;
  final String dbName = 'expense.db';
  final String expenseTable = 'expense_table';
  Future<void> init() async {
    await _createDatabase();
    await _createExpenseTable();
  }

  Future<Database> _createDatabase() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, dbName);
    _expenseDb = await openDatabase(path);
    return _expenseDb;
  }

  Future<void> _createExpenseTable() async {
    return await _expenseDb.execute(
        'create table is not exists $expenseTable(id integer primary key,name text,cost integer,time text,category nullable)');
  }

  Future insertExpense(
      {required String name,
      required int cost,
      required String time,
      required String category}) {
    return _expenseDb
        .execute('insert into $expenseTable(name,cost,time,category)'
            'values("$name",$cost,"$time","$category")');
  }

  Future<List<ExpenseModel>> getAllExpense() async {
    List<Map<String, dynamic>> expenseMap =
        await _expenseDb.rawQuery('select * from $expenseTable');
    return expenseMap.map((e) {
      return ExpenseModel.fromJson(e);
    }).toList();
  }

  Future<Map<String, dynamic>> totalCost() async {
    final totalCost =
        await _expenseDb.rawQuery('select SUM(cost) from $expenseTable');
    return totalCost[0];
  }

  Future<List<ExpenseModel>> getAllExpenseByDate(String date) async {
    List<Map<String, dynamic>> expenseMap = await _expenseDb
        .rawQuery('select * from $expenseTable where time like "$date%" ');
    return expenseMap.map((e) {
      return ExpenseModel.fromJson(e);
    }).toList();
  }

  Future<Map<String, dynamic>> totalCostOfDay(String date) async {
    final costOFDay = await _expenseDb.rawQuery(
        'select SUM(cost) from $expenseTable where time like "$date%');
    return costOFDay[0];
  }

  Future<List<String>> getDateList() async {
    final rawDateList =
        await _expenseDb.rawQuery('select time from $expenseTable');
    final dateList = rawDateList
        .map((e) {
          String rawDate = e['time'].toString();
          String date = rawDate.split('')[0];
          return date;
        })
        .toSet()
        .toList();
    return dateList;
  }

  Future<List<Map<String, dynamic>>> getUniqueCategory() async {
    final uniqueCategory = await _expenseDb
        .rawQuery('select distinct category form $expenseTable');
    return uniqueCategory;
  }

  Future<Map<String, dynamic>> totalCostByCategory(String category) async {
    final totalCost = await _expenseDb.rawQuery(
        'select SUM(cost) from $expenseTable where category = "$category"');
    return totalCost[0];
  }

  Future deleteExpenseById(int id) async {
    await _expenseDb.rawQuery('delete from $expenseTable where id= "$id"');
  }
}
