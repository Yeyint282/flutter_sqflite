import 'package:flutter/material.dart';
import 'package:flutter_sqflite/ui/screen/all_expense_list.dart';
import 'package:flutter_sqflite/ui/screen/home.dart';
import 'package:flutter_sqflite/ui/screen/setting_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    super.key,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late Widget _body = const Home();
  late List<Widget> _bodyList;
  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    _bodyList = [
      const Home(),
      const AllExpenseList(),
      const SettingScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body,
      bottomNavigationBar: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: (index) {
            setState(() {
              _selectedIndex = index;
              _body = _bodyList[index];
            });
          },
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
            NavigationDestination(icon: Icon(Icons.list), label: 'All Expense'),
            NavigationDestination(
                icon: Icon(Icons.category), label: 'Category'),
          ]),
    );
  }
}
