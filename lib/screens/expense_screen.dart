import 'package:expense_tracker_app/providers/expense_provider.dart';
import 'package:expense_tracker_app/screens/add_expense_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key});

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  late Future<void> _loadExpensesFuture;

  @override
  void initState() {
    super.initState();
    _loadExpensesFuture =
        Provider.of<ExpenseProvider>(context, listen: false).loadExpense();
  }

  @override
  Widget build(BuildContext context) {
    final expenseProvider = Provider.of<ExpenseProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ExpenseScreen',
        ),
      ),
      body: FutureBuilder(
          future: _loadExpensesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (expenseProvider.expenses.isEmpty) {
              return Center(
                child: Text('Add your first expense'),
              );
            } else {
              return ListView.builder(
                itemCount: expenseProvider.expenses.length,
                itemBuilder: (context, index) {
                  final expense = expenseProvider.expenses[index];
                  return ListTile(
                    title: Text(expense.title),
                    subtitle: Text(expense.amount.toString()),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        expenseProvider.removeExpenses(expense.id!);
                      },
                    ),
                  );
                },
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddExpenseScreen(),
            ),
          ); 
          if (result==true){
            setState(() {
              _loadExpensesFuture=expenseProvider.loadExpense();
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
