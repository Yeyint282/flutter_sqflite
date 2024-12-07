import 'package:flutter/cupertino.dart';
import 'package:flutter_sqflite/database/expense_db.dart';

class DatabaseProvider extends InheritedWidget{
  const DatabaseProvider(this.expenseDatabaseHelper, {super.key, required super.child});
final ExpenseDatabaseHelper expenseDatabaseHelper;
static DatabaseProvider of(BuildContext context){
  return (context.dependOnInheritedWidgetOfExactType<DatabaseProvider>())!;
}
  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }

}