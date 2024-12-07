import 'package:flutter/material.dart';
import 'package:flutter_sqflite/ui/widget/expense_list_widget.dart';
import 'package:flutter_sqflite/ui/widget/expense_total_cost_widget.dart';

import '../../database/model/expense_model.dart';

class ExpenseListDetailWidget extends StatelessWidget {
  const ExpenseListDetailWidget(
      {super.key,
      required this.todayCostFuture,
      required this.todayExpenseFuture,
      this.delete});

  final Future<Map<String, dynamic>> todayCostFuture;
  final Future<List<ExpenseModel>> todayExpenseFuture;
  final Function(int)? delete;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ExpenseTotalCost(todayCostFuture: todayCostFuture),
        const Divider(),
        Expanded(
          child: ExpenseListWidget(
            expenseFuture: todayExpenseFuture,
            delete: delete,
          ),
        ),
      ],
    );
  }
}
