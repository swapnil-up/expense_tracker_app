import 'package:expense_tracker_app/models/expense_categories.dart';
import 'package:expense_tracker_app/models/expense_model.dart';
import 'package:expense_tracker_app/providers/expense_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  ExpenseCategory _category = ExpenseCategory.Food;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add an Expense'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _amountController,
              decoration: InputDecoration(labelText: 'Amount'),
            ),
            Row(
              children: [
                Text('Date: ${_selectedDate.toLocal()}'),
                IconButton(
                  onPressed: () async {
                    final DateTime? pickedDate = await showDatePicker(
                      context: context,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                      initialDate: _selectedDate,
                    );
                    if (pickedDate != null) {
                      setState(() {
                        _selectedDate = pickedDate;
                      });
                    }
                  },
                  icon: Icon(Icons.calendar_today),
                ),
              ],
            ),
            DropdownButton<ExpenseCategory>(
              value: _category,
              items: ExpenseCategory.values.map((ExpenseCategory category) {
                return DropdownMenuItem<ExpenseCategory>(
                  value: category,
                  child: Text(category.toString().split('.').last),
                );
              }).toList(),
              onChanged: (ExpenseCategory? newValue) {
                setState(() {
                  _category = newValue!;
                });
              },
            ),
            ElevatedButton(
                onPressed: () {
                  final expense = Expense(
                    title: _titleController.text,
                    amount: int.parse(_amountController.text),
                    dateTime: _selectedDate,
                    category: _category,
                  );
                  Provider.of<ExpenseProvider>(context, listen: false)
                      .addExpenses(expense);
                  Navigator.pop(context);
                },
                child: Text('Add Expense'))
          ],
        ),
      ),
    );
  }
}
