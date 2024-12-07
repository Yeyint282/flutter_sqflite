import 'package:flutter/material.dart';
import 'package:flutter_sqflite/inherited_widget/database_provider.dart';
import 'package:flutter_sqflite/ui/screen/expense_list_detail_screen.dart';
import 'package:flutter_sqflite/ui/widget/expense_total_cost_widget.dart';

class AllExpenseList extends StatefulWidget {
  const AllExpenseList({super.key});

  @override
  State<AllExpenseList> createState() => _AllExpenseListState();
}

class _AllExpenseListState extends State<AllExpenseList> {
  late DatabaseProvider databaseProvider;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    databaseProvider = DatabaseProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: databaseProvider.expenseDatabaseHelper.getDateList(),
        builder: (context, snapShot) {
          if (snapShot.hasData) {
            List<String> dateList = snapShot.data ?? [];
            return Column(
              children: [
                AppBar(),
                Text('${dateList.length} days'),
                ExpenseTotalCost(
                    todayCostFuture:
                        databaseProvider.expenseDatabaseHelper.totalCost()),
                Expanded(
                  child: ListView.builder(
                      itemCount: dateList.length,
                      itemBuilder: (context, index) {
                        String date = dateList[index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ExpenseListDetailScreen(
                                    todayCostFuture: databaseProvider
                                        .expenseDatabaseHelper
                                        .totalCostOfDay(date),
                                    todayExpenseFuture: databaseProvider
                                        .expenseDatabaseHelper
                                        .getAllExpenseByDate(date),
                                    date: date),
                              ),
                            );
                          },
                          child: Card(
                            child: ListTile(
                              title: Text(date),
                              trailing: ExpenseTotalCost(
                                todayCostFuture: databaseProvider
                                    .expenseDatabaseHelper
                                    .totalCostOfDay(date),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ],
            );
          } else if (snapShot.hasError) {
            return const Center(
              child: Text('Something Wrong'),
            );
          }
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        });
  }
}
