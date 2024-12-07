import 'package:flutter/material.dart';
import 'package:flutter_sqflite/ui/widget/expense_list_detail_widget.dart';
import 'package:flutter_sqflite/utils/date_time_utils.dart';

import '../../database/model/expense_model.dart';

class ExpenseListDetailScreen extends StatefulWidget {
  const ExpenseListDetailScreen(
      {super.key,
      required this.todayCostFuture,
      required this.todayExpenseFuture,
      required this.date});
  final Future<Map<String, dynamic>> todayCostFuture;
  final Future<List<ExpenseModel>> todayExpenseFuture;
  final String date;
  @override
  State<ExpenseListDetailScreen> createState() =>
      _ExpenseListDetailScreenState();
}

class _ExpenseListDetailScreenState extends State<ExpenseListDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            '${widget.date} ${widget.date == todayDate() ? '(Today)' : ''}'),
      ),
      body: ExpenseListDetailWidget(
          todayCostFuture: widget.todayCostFuture,
          todayExpenseFuture: widget.todayExpenseFuture),
    );
  }
}
