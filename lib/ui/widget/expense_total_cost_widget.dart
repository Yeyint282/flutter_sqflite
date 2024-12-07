
import 'package:flutter/material.dart';

class ExpenseTotalCost extends StatelessWidget {
  const ExpenseTotalCost({
    super.key,
    required Future<Map<String, dynamic>> todayCostFuture,
  }) : _todayCostFuture = todayCostFuture;

  final Future<Map<String, dynamic>> _todayCostFuture;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
        future: _todayCostFuture,
        builder: (context, snapShot) {
          if (snapShot.hasData) {
            return Text(
              'Total cost- ${snapShot.data?['SUM(cost)'] ?? 0} Ks',
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.blue),
            );
          } else if (snapShot.hasError) {
            return const Text('Something Wrong');
          }
          return const Center(
              child: CircularProgressIndicator.adaptive());
        });
  }
}
