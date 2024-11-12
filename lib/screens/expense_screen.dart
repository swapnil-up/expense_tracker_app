import 'package:expense_tracker_app/providers/expense_provider.dart';
import 'package:expense_tracker_app/screens/add_expense_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseScreen extends StatelessWidget {
  const ExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final expenseProvider = Provider.of<ExpenseProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ExpenseScreen',
        ),
      ),
      body: ListView.builder(
        itemCount: expenseProvider.expenses.length,
        itemBuilder: (context, index) {
          final expense = expenseProvider.expenses[index];
          return ListTile(
            title: Text(expense.title),
            subtitle: Text(expense.amount.toString()),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                expenseProvider.removeExpenses(expense);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddExpenseScreen(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
