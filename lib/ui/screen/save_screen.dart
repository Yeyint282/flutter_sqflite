import 'package:flutter/material.dart';
import 'package:flutter_sqflite/database/expense_db.dart';

class SaveScreen extends StatefulWidget {
  const SaveScreen({super.key, required this.expenseDatabaseHelper});
  final ExpenseDatabaseHelper expenseDatabaseHelper;

  @override
  State<SaveScreen> createState() => _SaveScreenState();
}

class _SaveScreenState extends State<SaveScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  String? _name, _cost, _category;
  @override
  Widget build(BuildContext context) {
    return Form(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          key: _formKey,
          children: [
            TextFormField(
              validator: (name) {
                if (name == null || name.isEmpty) {
                  return 'Please Enter Your Name';
                }
                return null;
              },
              onSaved: (name) {
                _name = name;
              },
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
            ),
            TextFormField(
              validator: (cost) {
                if (cost == null || cost.isEmpty) {
                  return 'Enter your cost';
                }
                return null;
              },
              onSaved: (cost) {
                _cost = cost;
              },
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Cost',
              ),
            ),
            TextFormField(
              validator: (category) {
                if (category == null || category.isEmpty) {
                  return 'Enter your Category';
                }
                return null;
              },
              onSaved: (category) {
                _category = category;
              },
              decoration: const InputDecoration(
                labelText: 'Category',
              ),
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () async {
                    _formKey.currentState?.save();
                    if (_formKey.currentState?.validate() ?? false) {
                      DateTime now = DateTime.now();
                      int? cost = int.tryParse(_cost!);
                      if (cost != null) {
                        await widget.expenseDatabaseHelper.insertExpense(
                            name: _name!,
                            cost: cost,
                            time: now.toString(),
                            category: _category!);
                      }
                      if (mounted) {
                        Navigator.pop(context,'inserted');
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: const Text('Successfully save'),
                          action:
                              SnackBarAction(label: 'Undo', onPressed: () {}),
                          duration: const Duration(seconds: 1),
                        ));
                      }
                    }
                  },
                  child: const Text('Save'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
