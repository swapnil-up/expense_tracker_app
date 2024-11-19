import 'package:expense_tracker_app/models/expense_categories.dart';
import 'package:expense_tracker_app/providers/expense_provider.dart';
import 'package:expense_tracker_app/screens/add_expense_screen.dart';
import 'package:expense_tracker_app/services/export_expenses_to_csv.dart';
import 'package:expense_tracker_app/widgets/category_pie_chart.dart';
import 'package:expense_tracker_app/widgets/filter_sort_options.dart';
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
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              _showFilteredModal(context);
            },
          ),
          IconButton(
            onPressed: () {
              ExportExpensesToCsv(context, expenseProvider.expenses);
            },
            icon: Icon(Icons.download),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: _loadExpensesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (expenseProvider.expenses.isEmpty) {
                  return Center(
                    child: Text('Nothing to see here'),
                  );
                } else {
                  return ListView.builder(
                    itemCount: expenseProvider.filteredExpenses.length,
                    itemBuilder: (context, index) {
                      final expense = expenseProvider.filteredExpenses[index];
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
              },
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            child: CategoryPieChart(),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddExpenseScreen(),
            ),
          );
          if (result == true) {
            setState(() {
              _loadExpensesFuture = expenseProvider.loadExpense();
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showFilteredModal(BuildContext context) async {
    final selectedCategory = await showModalBottomSheet<ExpenseCategory>(
        context: context,
        builder: (context) {
          return const FilterSortOptions();
        });

    if (selectedCategory != null) {
      Provider.of<ExpenseProvider>(context, listen: false)
          .setCategoryFilter(selectedCategory);
    }
  }
}
